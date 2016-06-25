require 'spec_helper'

describe ChartmogulClient::V1::Import::Customers::ImportRq do
  it 'uses post http method' do
    expect(subject.http_method).to eq(ChartmogulClient::Consts::HttpMethods::POST)
  end

  it 'has path' do
    expect(subject.path).to eq('/import/customers')
  end

  it 'has attributes that can be setup' do
    [
      :data_source_uuid, :external_id, :name, :email,
      :company, :country, :state, :city, :zip
    ].each do |attribute|
      expect(subject).to respond_to("#{attribute}=".to_sym)
    end
  end

  it 'has request body containg all attributes' do
    subject.data_source_uuid = 'ds_1234'
    subject.external_id = '123456'
    subject.name = 'Customer Name'
    subject.email = 'anything@example.com'
    subject.company = 'Test Company'
    subject.country = 'PL'
    subject.state = 'DL'
    subject.city = 'Wroclaw'
    subject.zip = '55'

    expect(subject.http_request_body).to eq({
      'data_source_uuid' => 'ds_1234',
      'external_id' => '123456',
      'name' => 'Customer Name',
      'email' => 'anything@example.com',
      'company' => 'Test Company',
      'country' => 'PL',
      'state' => 'DL',
      'city' => 'Wroclaw',
      'zip' => '55',
    })
  end
end