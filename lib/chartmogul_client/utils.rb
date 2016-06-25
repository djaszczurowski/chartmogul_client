module ChartmogulClient::Utils
  #validation helpers
  def self.blank_string?(o)
    o.to_s.length == 0
  end

  def self.country_code?(code)
    code =~ /^[A-Z]{2}$/
  end

  def self.email?(string)
    string =~ /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  end

  # error messages
  def self.req_err(attribute)
    "#{attribute} is required"
  end

  def self.country_err
    'country code must be 2 upcased letters[ISO_3166-1]'
  end

  def self.email_err
    'invalid email'
  end
end