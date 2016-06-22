require 'spec_helper'

describe ChartmogulClient::V1::Import::DataSources::Validators::CreateRqValidator do
  subject { described_class }

  it 'validates whether name setup' do
    rq = ChartmogulClient::V1::Import::DataSources::CreateRq.new
    expect(subject.valid?(rq)).to eq(['name is required'])

    rq.name = 'anything'
    expect(subject.valid?(rq)).to eq([])
  end
end