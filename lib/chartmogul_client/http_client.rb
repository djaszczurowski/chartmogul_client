require 'net/http'
require 'multi_json'

module ChartmogulClient::HttpClient
  def self.call(input_rq)
    uri = URI("#{input_rq.base_url}/#{input_rq.api_version}#{input_rq.path}")

    Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http_connection|
      http_request = http_request_from_method(input_rq, uri)
      http_request.basic_auth(input_rq.account_token, input_rq.security_key)
      http_request.body = MultiJson.dump(input_rq.http_request_body)

      http_response = http_connection.request(http_request)

      [MultiJson.load(http_response.body), http_response.code.to_i]
    end
  end

  def self.http_request_from_method(input_rq, uri)
    http_method = input_rq.http_method

    case http_method
    when ChartmogulClient::Consts::HttpMethods::GET
      Net::HTTP::Get.new(uri, input_rq.http_headers)
    when ChartmogulClient::Consts::HttpMethods::DELETE
      Net::HTTP::Delete.new(uri, input_rq.http_headers)
    when ChartmogulClient::Consts::HttpMethods::POST
      Net::HTTP::Post.new(uri.request_uri, input_rq.http_headers)
    else
      raise "Can't create http request, unknown http method: #{http_method}"
    end
  end
end