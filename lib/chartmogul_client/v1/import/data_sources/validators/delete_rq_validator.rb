module ChartmogulClient::V1::Import::DataSources::Validators
  module DeleteRqValidator
    def self.valid?(rq)
      errors = []
      errors << 'uuid is required' if rq.uuid.nil?
      errors
    end
  end
end