module ChartmogulClient::V1::Import::DataSources::Validators
  module CreateRqValidator
    def self.valid?(rq)
      utils = ChartmogulClient::Utils

      errors = []
      errors << utils.req_err('name') if utils.blank_string?(rq.name)
      errors
    end
  end
end