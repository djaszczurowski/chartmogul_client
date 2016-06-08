require 'spec_helper'

describe ChartmogulClient::ApiClient do
  subject { described_class }

  let(:request) { instance_double(ChartmogulClient::V1::BaseRq) }

  context 'when request is invalid' do
    it 'returns 400 with error messages' do
      expect(ChartmogulClient::RqValidator).to receive(:valid?).and_return([false, ["name must be present"]])

      response = subject.call(request)

      expect(response.status).to eq(400)
      expect(response.errors).to eq(["name must be present"])
    end
  end

  context 'when request is valid' do
    context 'when request processed' do
      it 'returns response with API status and its response body' do
        response_body = {}
        response_status = 201

        expect(ChartmogulClient::RqValidator).to receive(:valid?).and_return([true])
        expect(ChartmogulClient::HttpClient).to receive(:call).with(request).and_return([response_body, response_status])

        response = subject.call(request)

        expect(response.body).to be(response_body)
        expect(response.status).to be(response_status)
        expect(response.errors).to eq([])
      end
    end

    context 'when error occured during processing' do
      it 'returns 500 with caught error message' do
        expect(ChartmogulClient::RqValidator).to receive(:valid?).and_return([true])
        expect(ChartmogulClient::HttpClient).to receive(:call).and_raise("Error message")

        response = subject.call(request)

        expect(response.body).to be(nil)
        expect(response.status).to be(500)
        expect(response.errors).to eq(["Error message"])
      end
    end
  end
end