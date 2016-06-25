require 'spec_helper'

describe ChartmogulClient::V1::Import::Customers::Validators::ImportRqValidator do
  subject { described_class }

  it 'validates whether required attributes present' do
    rq = ChartmogulClient::V1::Import::Customers::ImportRq.new
    expect(subject.valid?(rq)).to eq(['data_source_uuid is required', 'external_id is required', 'name is required'])
  end

  it 'validates whether country is 2 letter upcased string if provided' do
    rq = ChartmogulClient::V1::Import::Customers::ImportRq.new
    rq.country = 'PLA'
    expect(subject.valid?(rq)).to include('country code must be 2 upcased letters[ISO_3166-1]')

    rq = ChartmogulClient::V1::Import::Customers::ImportRq.new
    rq.country = 'PL'
    expect(subject.valid?(rq)).not_to include('country code must be 2 upcased letters[ISO_3166-1]')
  end

  it 'validates whether email if provided' do
    rq = ChartmogulClient::V1::Import::Customers::ImportRq.new
    rq.email = '@example.com'
    expect(subject.valid?(rq)).to include('invalid email')

    rq = ChartmogulClient::V1::Import::Customers::ImportRq.new
    rq.email = 'anything@example.com'
    expect(subject.valid?(rq)).not_to include('invalid email')
  end
end