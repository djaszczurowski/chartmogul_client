module ChartmogulClient::V1::Import::Customers::Validators
  module ImportRqValidator
    def self.valid?(rq)
      utils = ChartmogulClient::Utils

      errors = []
      errors << utils.req_err('data_source_uuid') if utils.blank_string?(rq.data_source_uuid)
      errors << utils.req_err('external_id') if utils.blank_string?(rq.external_id)
      errors << utils.req_err('name') if utils.blank_string?(rq.name)

      unless utils.blank_string?(rq.country)
        unless utils.country_code?(rq.country)
          errors << utils.country_err
        end
      end

      unless utils.blank_string?(rq.email)
        unless utils.email?(rq.email)
          errors << utils.email_err
        end
      end

      errors
    end
  end
end