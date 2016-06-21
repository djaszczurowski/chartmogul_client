require 'spec_helper'
require 'webmock/rspec'

describe ChartmogulClient::HttpClient do
  subject { described_class }

  let(:request) { instance_double(ChartmogulClient::V1::BaseRq) }

  class HttpClientTestRq < ChartmogulClient::V1::BaseRq
    def initialize(test_http_method)
      @test_http_method = test_http_method
    end

    def path
      "/test"
    end

    def http_method
      @test_http_method
    end
  end

  describe 'call' do
    [:get, :post].each do |test_http_method|
      context "#{test_http_method} method" do
        it 'rewrites all headers to http request, adds auth and returns response body with code' do
          input_rq = HttpClientTestRq.new(test_http_method)
          input_rq.security_key = 'security_key'
          input_rq.account_token = 'account_token'
          input_rq.base_url = "http://example.com"

          stub_request(test_http_method, "http://example.com/test").
             with(basic_auth: ['account_token', 'security_key'], :headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'Host'=>'example.com', 'User-Agent'=>'Ruby'}).
             to_return(:status => 200, :body => {'status' => 'ok'}.to_json , :headers => {'Content-Type' => 'application/json'})

          body, status = subject.call(input_rq)

          expect(body).to eq("{\"status\":\"ok\"}")
          expect(status).to eq(200)
        end
      end
    end
  end
end