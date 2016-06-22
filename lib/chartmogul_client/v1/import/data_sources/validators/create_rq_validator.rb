module ChartmogulClient::V1::Import::DataSources::Validators
  module CreateRqValidator
    def self.valid?(rq)
      errors = []
      errors << 'name is required' if rq.name.nil?
      errors
    end
  end
end