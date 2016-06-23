module ChartmogulClient
  class OnlineTester
    def initialize(account_token, security_key, base_url = "https://api.chartmogul.com")
      @account_token = account_token
      @security_key = security_key
      @base_url = base_url
      @logger = ChartmogulClient::Loggers::TesterLogger.new
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

    def test_import_data_sources_delete_rq
      response = test_import_data_sources_list_rq
      data_sources = ((response.body || {})['data_sources'] || [])
      raise "No items to delete" if data_sources.empty?

      rq = create_rq(ChartmogulClient::V1::Import::DataSources::DeleteRq)
      rq.uuid = data_sources.first['uuid']
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
      ChartmogulClient::ApiClient.call(rq, @logger)
    end
  end
end