require 'net/http'
require 'multi_json'

module ChartmogulClient::HttpClient
  def self.call(input_rq, logger)
    uri = URI("#{input_rq.base_url}/#{input_rq.api_version}#{input_rq.path}")
    logger.debug("request uri: #{uri}")

    Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http_connection|
      http_request = http_request_from_method(input_rq, uri)
      http_request.basic_auth(input_rq.account_token, input_rq.security_key)

      http_request.body = prepare_request_body(input_rq)
      logger.debug("request body: #{http_request.body}")

      http_response = http_connection.request(http_request)
      logger.debug("API code/response: #{http_response.code}/#{http_response.body}")

      begin
        prepare_response(http_response)
      rescue => e
        raise "Failed when parsing API response. Original code: #{http_response.code}; response: #{http_response.body}"
      end
    end
  end

  def self.prepare_request_body(input_rq)
    if input_rq.http_headers['Content-Type'] == 'application/json'
      MultiJson.dump(input_rq.http_request_body)
    else
      input_rq.http_request_body
    end
  end

  def self.prepare_response(http_response)
    code = http_response.code.to_i
    body = http_response.body

    if http_response['content-type'].include?('application/json')
      body = MultiJson.load(body)
    end

    [body, code]
  end

  def self.http_request_from_method(input_rq, uri)
    http_method = input_rq.http_method

    case http_method
    when ChartmogulClient::Consts::HttpMethods::GET
      Net::HTTP::Get.new(uri.request_uri, input_rq.http_headers)
    when ChartmogulClient::Consts::HttpMethods::DELETE
      Net::HTTP::Delete.new(uri.request_uri, input_rq.http_headers)
    when ChartmogulClient::Consts::HttpMethods::POST
      Net::HTTP::Post.new(uri.request_uri, input_rq.http_headers)
    else
      raise "Can't create http request, unknown http method: #{http_method}"
    end
  end
end