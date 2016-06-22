module ChartmogulClient::RqValidator
  def self.valid?(request)
    valid, errors = BasicValidator.valid?(request)
    return [valid, errors] unless valid

    CustomValidator.valid?(request)
  end
end