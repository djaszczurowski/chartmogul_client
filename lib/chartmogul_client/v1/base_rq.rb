module ChartmogulClient::V1
  class BaseRq
    attr_accessor :security_key
    attr_accessor :account_token

    def api_version
      ChartmogulClient::Consts::ApiVersions::V1
    end

    def path
      raise "path must be overriden for #{self.class}"
    end

    def http_method
      raise "http method must be overriden for #{self.class}"
    end

    def http_headers
      @http_headers ||=
        {
          'Content-Type' => 'application/json',
          'Accept' => 'application/json'
        }
    end
  end
end