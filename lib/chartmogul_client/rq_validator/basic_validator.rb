module ChartmogulClient::RqValidator::BasicValidator
  def self.valid?(request)
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

  private_class_method :validate_uri
  private_class_method :validate_specific_api_version
end