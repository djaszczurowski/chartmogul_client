module ChartmogulClient::V1::Import::DataSources
  class CreateRq < ChartmogulClient::V1::BaseRq
    attr_accessor :name

    def path
      '/import/data_sources'
    end

    def http_method
      :post
    end

    def http_request_body
      {
        'name' => name
      }
    end
  end
end