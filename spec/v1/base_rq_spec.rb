require 'spec_helper'

describe ChartmogulClient::V1::BaseRq do
  context 'failing scenarios' do
    class FailTestRq < ChartmogulClient::V1::BaseRq
    end

    subject { FailTestRq.new }

    it 'fails when path not overriden' do
      expect { subject.path }.to raise_error("path must be overriden for FailTestRq")
    end

    it 'fails when http_method not overriden' do
      expect { subject.http_method }.to raise_error("http method must be overriden for FailTestRq")
    end
  end

  context 'sunny scenarios' do
    class TestRq < ChartmogulClient::V1::BaseRq
      def path
        "/customers"
      end

      def http_method
        :get
      end
    end

    subject { TestRq.new }

    it 'returns path' do
      expect(subject.path).to eq("/customers")
    end

    it 'returns http method' do
      expect(subject.http_method).to eq(:get)
    end

    it 'returns common headers by default' do
      expect(subject.http_headers).to eq(
        {
          'Content-Type' => 'application/json',
          'Accept' => 'application/json'
        }
      )
    end
  end

end