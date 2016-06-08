module ChartmogulClient::V1
  class BaseRq
    def path
      raise "path must be overriden for #{self.class}"
    end

    def method
      raise "method must be overriden for #{self.class}"
    end

    def as_json(arg)
      raise "as_json must be overriden for #{self.class}"
    end

    def headers
      {
        'Content-Type' => 'application/json'
      }
    end
  end
end