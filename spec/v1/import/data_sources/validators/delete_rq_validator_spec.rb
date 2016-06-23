require 'spec_helper'

describe ChartmogulClient::V1::Import::DataSources::Validators::DeleteRqValidator do
  subject { described_class }

  it 'validates whether uuid setup' do
    rq = ChartmogulClient::V1::Import::DataSources::DeleteRq.new
    expect(subject.valid?(rq)).to eq(['uuid is required'])

    rq.uuid = 'anything'
    expect(subject.valid?(rq)).to eq([])
  end
end