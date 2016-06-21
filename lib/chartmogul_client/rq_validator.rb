module ChartmogulClient::RqValidator
  def self.valid?(request)
    valid, errors = run_basic_validation(request)

    return [valid, errors] unless valid

    validator = try_find_custom_validator(request)

    if validator
      validator.valid?(request)
    else
      [true, []]
    end
  end

  def self.run_basic_validation(request)
    errors = validate_uri(request)
    return [false, errors] unless errors.empty?

    errors = validate_specific_api_version(request)
    [errors.empty?, errors]
  end

  def self.validate_uri(request)
    errors = []

    if request.base_url
      uri = URI.parse("#{request.base_url}#{request.path}")
      unless (uri.is_a?(URI::HTTP) || uri.is_a?(URI::HTTPS))
        errors << "invalid url: #{uri.to_s}"
      end
    else
      errors << "missing base_url"
    end

    errors
  end

  def self.validate_specific_api_version(request)
    errors = []

    case request.api_version
    when ChartmogulClient::Consts::ApiVersions::V1
      if request.security_key.nil? || request.account_token.nil?
        errors << 'security_key/account_token missing'
      end
    else
      raise "Unknown API version #{request.api_version}"
    end

    errors
  end

  def self.try_find_custom_validator(request)
    splitted_namespaces = request.class.name.split('::')
    validator_scope = splitted_namespaces[0..-2].join('::')
    validator_name =
      "#{validator_scope}::Validators::#{splitted_namespaces[-1]}Validator"

    if Object.const_defined?(validator_name)
      validator = Object.const_get(validator_name)

      unless validator.respond_to?(:valid?)
        raise "Validator #{validator_name} should respond to valid?"
      end

      validator
    end
  end

  private_class_method :try_find_custom_validator
  private_class_method :run_basic_validation
end