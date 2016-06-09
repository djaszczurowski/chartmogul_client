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
    case request.api_version
    when ChartmogulClient::Consts::ApiVersions::V1
      errors = []

      if request.security_key.nil? || request.account_token.nil?
        errors << 'security_key/account_token missing'
      end

      [errors.empty?, errors]
    else
      raise "Unknown API version #{request.api_version}"
    end
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