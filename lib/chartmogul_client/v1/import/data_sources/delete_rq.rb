module ChartmogulClient::V1::Import::DataSources
  class DeleteRq < ChartmogulClient::V1::BaseRq
    attr_accessor :uuid

    def path
      "/import/data_sources/#{uuid}"
    end

    def http_method
      ChartmogulClient::Consts::HttpMethods::DELETE
    end

    def http_request_body
      nil
    end

    def http_headers
      {}
    end
  end
end