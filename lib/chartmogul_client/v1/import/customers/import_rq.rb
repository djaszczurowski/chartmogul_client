module ChartmogulClient::V1::Import::Customers
  class ImportRq < ChartmogulClient::V1::BaseRq
    attr_accessor :data_source_uuid
    attr_accessor :external_id
    attr_accessor :name
    attr_accessor :email
    attr_accessor :company
    attr_accessor :country
    attr_accessor :state
    attr_accessor :city
    attr_accessor :zip

    def http_method
      ChartmogulClient::Consts::HttpMethods::POST
    end

    def path
      '/import/customers'
    end

    def http_request_body
      {
        'data_source_uuid' => data_source_uuid,
        'external_id' => external_id,
        'name' => name,
        'email' => email,
        'company' => company,
        'country' => country,
        'state' => state,
        'city' => city,
        'zip' => zip
      }
    end
  end
end