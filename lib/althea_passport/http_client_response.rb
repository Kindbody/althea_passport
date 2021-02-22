module AltheaPassport
  class HttpClientResponse
    attr_reader :response
    def initialize(response)
      @response = response
    end

    def body
      if response.is_a?(HTTP::Response)
        response.body.to_s
      end
    end

    def json
      @json ||= JSON.parse(body)
    end

    def success?
      status < 400
    end

    def status
      response.status
    end

    def flush
      if response.is_a?(HTTP::Response)
        response.flush
      end
    end
  end
end