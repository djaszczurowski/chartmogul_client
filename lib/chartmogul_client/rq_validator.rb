module ChartmogulClient::RqValidator
  def self.valid?(request)
    validator = try_find_custom_validator(request)

    if validator
      validator.valid?(request)
    else
      [true, []]
    end
  end

  def self.try_find_custom_validator(request)
    splitted_namespaces = request.class.name.split('::')
    validator_scope = splitted_namespaces[0..-2].join('::')
    validator_name =
      "#{validator_scope}::Validators::#{splitted_namespaces[-1]}Validator"

    if Object.const_defined?(validator_name)
      validator = Object.const_get(validator_name)

      unless validator.respond_to?(:valid?)
        raise "Validator #{validator_name} should respond to valid?"
      end

      validator
    end
  end

  private_class_method :try_find_custom_validator
end