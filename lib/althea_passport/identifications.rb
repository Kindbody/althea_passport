module AltheaPassport
  class Identifications

    class << self
      def get(path, token, cache: {})
        HttpClient.new(:get, url(path), token, cache: cache).call.json
      end

      def post(path, body, token, cache: {})
        HttpClient.new(:post, url(path), token, body, cache: cache).call.json
      end

      def url(path)
        "#{AltheaPassport.configuration.idp_url}/api#{path}"
      end
    end

  end
end