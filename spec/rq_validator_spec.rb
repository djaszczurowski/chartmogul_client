require 'spec_helper'

describe ChartmogulClient::RqValidator do
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

  subject { described_class }

  context 'when no validator for request found' do
    it 'returns true' do
      rq = ChartmogulClient::V1::Test::NoValidatorRq.new
      rq.security_key = 'security_key'
      rq.account_token = 'account_token'

      expect(subject.valid?(rq)).to eq([true, []])
    end
  end

  context 'when validator found but valid? method doesnt exist' do
    it 'raises an error' do
      rq = ChartmogulClient::V1::Test::NoValidMethodRq.new
      rq.security_key = 'security_key'
      rq.account_token = 'account_token'

      expect { subject.valid?(rq) }.to raise_error("Validator ChartmogulClient::V1::Test::Validators::NoValidMethodRqValidator should respond to valid?")
    end
  end

  context 'when API V1 request but security_key/account_token is missing' do
    it 'returns 400' do
      rq = ChartmogulClient::V1::Test::WithValidatorRq.new

      expect(subject.valid?(rq)).to eq([false, ['security_key/account_token missing']])
    end
  end

  context 'when validator for request found in tested_rq_directory/validators/tested_rq_validator' do
    it 'returns validator result' do
      rq = ChartmogulClient::V1::Test::WithValidatorRq.new
      rq.security_key = 'security_key'
      rq.account_token = 'account_token'

      validator_result = [true, []]

      expect(ChartmogulClient::V1::Test::Validators::WithValidatorRqValidator).to receive(:valid?).with(rq).and_return(validator_result)
      expect(subject.valid?(rq)).to eq(validator_result)
    end
  end
end