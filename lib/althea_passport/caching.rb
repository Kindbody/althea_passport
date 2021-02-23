module AltheaPassport
  module Caching
    class Error < Exception; end

    def cache_block(key, expires_in:)
      raise Error, "no cache key" if key.nil?
      raise Error, "no cache expires_in" if expires_in.nil?

      key = calculate_cache_key(key)

      cached_value = app_cache.read(key)
      return cached_value if cached_value

      yield.tap do |block_result|
        cache_block_result(block_result, key, expires_in)
      end
    end

    def cache_block_result(block_result, key, expires_in)
      block_result.tap do
        next if block_result.is_a?(AltheaPassport::HttpClientResponse) && !block_result.success? # Cache only successful requests

        app_cache.write(key, block_result, expires_in: expires_in)
      end
    end

    def calculate_cache_key(key)
      "AltheaPassport::#{key}".gsub(/\s/, "/")
    end

    def app_cache
      @app_cache ||= Rails.cache
    end
  end
end