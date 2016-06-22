module ChartmogulClient::RqValidator::CustomValidator
  def self.valid?(request)
    splitted_namespaces = request.class.name.split('::')
    validator_scope = splitted_namespaces[0..-2].join('::')
    validator_name =
      "#{validator_scope}::Validators::#{splitted_namespaces[-1]}Validator"

    unless Object.const_defined?(validator_name)
      return [true, []]
    end

    validator = Object.const_get(validator_name)

    unless validator.respond_to?(:valid?)
      raise "Validator #{validator_name} should respond to valid?"
    end

    errors = validator.valid?(request)

    [errors.empty?, errors]
  end
end