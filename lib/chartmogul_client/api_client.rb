module ChartmogulClient::ApiClient
  def self.call(request)
    rq_valid, errors = ChartmogulClient::RqValidator.valid?(request)

    unless rq_valid
      return api_response(
        nil, ChartmogulClient::Consts::HttpStatuses::BAD_REQUEST, errors
      )
    end

    body, status = ChartmogulClient::HttpClient.call(request)

    api_response(body, status)
  rescue => e
    api_response(nil, ChartmogulClient::Consts::HttpStatuses::SERVER_ERROR, [e.message])
  end

  def self.api_response(body, status, errors = [])
    res = ChartmogulClient::ApiResponse.new
    res.body = body
    res.status = status
    res.errors = errors

    res
  end

  private_class_method :api_response
end