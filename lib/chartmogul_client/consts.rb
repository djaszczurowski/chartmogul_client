module ChartmogulClient::Consts
  module ApiVersions
    V1 = 'v1'
  end

  module HttpStatuses
    BAD_REQUEST = 400
    SERVER_ERROR = 500
  end

  module HttpMethods
    GET = :get
    POST = :post
    DELETE = :delete
  end
end