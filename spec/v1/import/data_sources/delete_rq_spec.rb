require 'spec_helper'

describe ChartmogulClient::V1::Import::DataSources::DeleteRq do
  it 'uses delete http method' do
    expect(subject.http_method).to eq(:delete)
  end

  it 'incudes uuid in path' do
    subject.uuid = "1234"
    expect(subject.path).to eq('/import/data_sources/1234')
  end
end