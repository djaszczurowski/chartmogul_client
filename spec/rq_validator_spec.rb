require 'spec_helper'

describe ChartmogulClient::RqValidator do
  subject { described_class }

  let(:request) { instance_double(ChartmogulClient::V1::BaseRq) }

  before do
    expect(ChartmogulClient::RqValidator::BasicValidator).to receive(:valid?)
      .with(request).and_return([basic_validator_status, basic_validator_errors])
  end

  context 'when BasicValidator failed' do
    let(:basic_validator_status) { false }
    let(:basic_validator_errors) { ['errors'] }

    it 'returns failed status with errors' do
      expect(subject.valid?(request)).to eq([false, ['errors']])
    end
  end

  context 'when BasicValidator succeeded' do
    let(:basic_validator_status) { true }
    let(:basic_validator_errors) { [] }

    it 'returns custom validator result' do
      custom_validator_status = true
      custom_validator_errors = []

      expect(ChartmogulClient::RqValidator::CustomValidator).to receive(:valid?)
        .with(request).and_return([custom_validator_status, custom_validator_errors])

      expect(subject.valid?(request)).to eq([true, []])
    end
  end
end