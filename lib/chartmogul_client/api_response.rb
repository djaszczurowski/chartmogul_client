module ChartmogulClient
  class ApiResponse
    attr_accessor :body
    attr_accessor :status
    attr_accessor :errors

    def errors
      @errors ||= []
    end
  end
end