require 'rest-client'

module AltheaPassport

  class Identifications

    BASE_URL = "#{AltheaPassport.configuration.idp_url}/api"

    class << self

      def get(path, token)
        RestClient.get(url(path), { Authorization: "Token #{token}" })
      end

      def post(path, body, token)
        RestClient.post(url(path), body, { Authorization: "Token #{token}" })
      end

      def url(path)
        "#{BASE_URL}#{path}"
      end

    end

  end

end