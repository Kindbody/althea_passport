module AltheaPassport
  class Identifications

    class << self
      def get(path, token)
        HttpClient.new(:get, url(path), token).call
      end

      def post(path, body, token)
        HttpClient.new(:post, url(path), token, body).call
      end

      def url(path)
        "#{AltheaPassport.configuration.idp_url}/api#{path}"
      end
    end

  end
end