module AltheaPassport
  class ApiBase
    attr_accessor :token

    class << self

      def call_althea_api(method, token, url, attributes = nil)
        response = Faraday.send(method, url, attributes) do |req|
          req.headers['Authorization'] = "Token #{token}"
        end

        if response.success?
          if block_given?
            yield(response)
          else
            response
          end
        elsif
          { status: :error, message: "HTTP STATUS CODE #{response.status}" }
        end
      end

    end
  end
end