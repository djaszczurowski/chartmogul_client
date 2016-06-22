require 'spec_helper'

describe ChartmogulClient::RqValidator::BasicValidator do
  subject { described_class }

  class BasicValidatorTestRq < ChartmogulClient::V1::BaseRq
    def path
      '/test'
    end
  end

  context 'when API base_url missing/invalid' do
    it 'returns 400' do
      rq = BasicValidatorTestRq.new
      expect(subject.valid?(rq)).to eq([false, ['missing base_url']])

      rq.base_url = "foo"
      expect(subject.valid?(rq)).to eq([false, ['invalid url: foo/test']])
    end
  end

  context 'when API V1 request but security_key/account_token is missing' do
    it 'returns 400' do
      rq = BasicValidatorTestRq.new
      rq.base_url = "http://example.com"

      expect(subject.valid?(rq)).to eq([false, ['security_key/account_token missing']])
    end
  end
end