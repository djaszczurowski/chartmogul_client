module ChartmogulClient
  class OnlineTester
    def initialize(account_token, security_key, base_url = "https://api.chartmogul.com")
      @account_token = account_token
      @security_key = security_key
      @base_url = base_url
    end

    def test_import_data_sources_create_rq(options = {})
      rq = create_rq(ChartmogulClient::V1::Import::DataSources::CreateRq)
      rq.name = options.fetch(:name, "Test name")

      call_rq(rq)
    end

    def test_import_data_sources_list_rq
      rq = create_rq(ChartmogulClient::V1::Import::DataSources::ListRq)
      call_rq(rq)
    end

    private

    def create_rq(klass)
      instance = klass.new
      instance.base_url = @base_url
      instance.security_key = @security_key
      instance.account_token = @account_token
      instance
    end

    def call_rq(rq)
      ChartmogulClient::ApiClient.call(rq)
    end
  end
end