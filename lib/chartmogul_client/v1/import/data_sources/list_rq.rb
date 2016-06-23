module ChartmogulClient::V1::Import::DataSources
  class ListRq < ChartmogulClient::V1::BaseRq
    def path
      '/import/data_sources'
    end

    def http_method
      ChartmogulClient::Consts::HttpMethods::GET
    end

    def http_request_body
      {}
    end
  end
end