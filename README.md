## Installation

Add this line to your application's Gemfile:

```ruby
gem 'chartmogul_client'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install chartmogul_client

## Usage

Prior to any actions go to chartmogul official site and register. Go to administration panel and copy your account_token and security_key

General flow is
```ruby
  #1. create request instance
  rq = ChartmogulClient::V1::Import::DataSources::CreateRq.new

  #2. setup request attributes if any
  rq.name = "data source name"

  #3. setup base url, security key and authentication token
  rq.base_url = "https://api.chartmogul.com"
  rq.security_key = "security_key"
  rq.account_token = "account_token"

  #4. call api client
  response = ChartmogulClient::ApiClient.call(rq)

  #5. read from response.
  response.body #parsed JSON from API
  response.status #http status f.e. 200
  response.errors #array of error strings

```

In order to test library, you may start with creating ChartmogulClient::OnlineTester
```ruby
tester = ChartmogulClient::OnlineTester.new(account_token, security_key)
tester.test_import_data_sources_create_rq # will create new data source with default name
tester.test_import_data_sources_list_rq # will return all your data sources
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).