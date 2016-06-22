require 'net/http'
require 'multi_json'

module ChartmogulClient::HttpClient
  def self.call(input_rq)
    uri = URI("#{input_rq.base_url}#{input_rq.path}")

    Net::HTTP.start(uri.host, uri.port) do |http_connection|
      http_request = http_request_from_method(input_rq.http_method, uri)
      http_request.basic_auth(input_rq.account_token, input_rq.security_key)
      http_request.body = input_rq.http_request_body.to_json
      input_rq.http_headers.each { |k, v| http_request[k] = v }

      http_response = http_connection.request(http_request)

      [MultiJson.load(http_response.body), http_response.code.to_i]
    end
  end

  def self.http_request_from_method(http_method, uri)
    case http_method
    when :get then Net::HTTP::Get.new(uri)
    when :post then Net::HTTP::Post.new(uri)
    else
      raise "Can't create http request, unknown http method: #{http_method}"
    end
  end
end