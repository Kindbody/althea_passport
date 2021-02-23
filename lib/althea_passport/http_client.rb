module AltheaPassport
  class HttpClient
    include AltheaPassport::Caching
    @@prev_request = nil
    attr_reader :method, :url, :data, :headers, :response, :token, :cache

    def initialize(method, url, token, data = nil, headers: {}, cache: {})
      @method = method
      @url = url
      @token = token
      @data = data
      @headers = headers
      @cache = cache
    end

    def call
      call_cached do
        @@prev_request&.flush

        if data
          @response = with_params
        else
          @response = without_params
        end

        @@prev_request = AltheaPassport::HttpClientResponse.new(response)
      end
    end

    private

    def call_cached
      return yield if cache.empty?
      cache_block(cache[:key], expires_in: cache[:expires_in]) do
        yield
      end
    end

    def with_params
      default_client.send(method, url, json: data)
    end

    def without_params
      default_client.send(method, url)
    end

    def default_client
      client = AltheaPassport::PersistentHttpClient.fetch(url)
      client.timeout(timeout).headers(build_headers)
    end

    def build_headers
      headers.merge(Authorization: "Token #{token}")
    end

    def timeout
      5
    end
  end
end