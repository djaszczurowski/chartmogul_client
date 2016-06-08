module ChartmogulClient::V1
  class BaseRq
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