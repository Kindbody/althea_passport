require 'rest-client'

module AltheaPassport

  class Identifications

    class << self

      def get(path, token)
        RestClient.get(url(path), { Authorization: "Token #{token}" })
      end

      def post(path, body, token)
        RestClient.post(url(path), body, { Authorization: "Token #{token}" })
      end

      def url(path)
        "#{AltheaPassport.configuration.idp_url}/api#{path}"
      end

    end

  end

end