require 'spec_helper'

describe ChartmogulClient::RqValidator::CustomValidator do
  subject { described_class }

  module ChartmogulClient::V1::Test
    module Validators
      module NoValidMethodRqValidator
      end

      module WithValidatorRqValidator
        def self.valid?(rq)
          raise "NIY"
        end
      end
    end

    class NoValidatorRq < ChartmogulClient::V1::BaseRq
    end

    class NoValidMethodRq < ChartmogulClient::V1::BaseRq
    end

    class WithValidatorRq < ChartmogulClient::V1::BaseRq
    end
  end


  context 'when no custom validator for rq found' do
    it 'returns true' do
      rq = ChartmogulClient::V1::Test::NoValidatorRq.new

      expect(subject.valid?(rq)).to eq([true, []])
    end
  end

  context 'when custom validator found but valid? method doesnt exist' do
    it 'raises an error' do
      rq = ChartmogulClient::V1::Test::NoValidMethodRq.new

      expect { subject.valid?(rq) }.to raise_error("Validator ChartmogulClient::V1::Test::Validators::NoValidMethodRqValidator should respond to valid?")
    end
  end

  context 'when validator for request found in tested_rq_directory/validators/tested_rq_validator' do
    it 'returns validator result' do
      rq = ChartmogulClient::V1::Test::WithValidatorRq.new
      validator_result = []

      expect(ChartmogulClient::V1::Test::Validators::WithValidatorRqValidator).to receive(:valid?).with(rq).and_return(validator_result)
      expect(subject.valid?(rq)).to eq([true, []])

      validator_result = ['anything']

      expect(ChartmogulClient::V1::Test::Validators::WithValidatorRqValidator).to receive(:valid?).with(rq).and_return(validator_result)
      expect(subject.valid?(rq)).to eq([false, ['anything']])
    end
  end
end