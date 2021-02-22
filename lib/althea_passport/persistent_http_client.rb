require "uri"
require "http"

module AltheaPassport
  class PersistentHttpClient
    include Singleton
    attr_reader :cache
    def initialize
      @cache = {}
    end

    class << self
      def fetch(url)
        h = host(url)
        instance.cache[h] ||= HTTP.persistent(h)
      end

      def flush(url)
        h = host(url)
        instance.cache[h]&.flush
      end

      def host(url)
        uri = URI.parse(url)
        "#{uri.scheme}://#{uri.host}"
      end
    end
  end
end