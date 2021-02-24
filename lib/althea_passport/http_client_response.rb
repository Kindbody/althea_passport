module AltheaPassport
  class HttpClientResponse
    attr_reader :response, :flushed
    def initialize(response)
      @response = response
    end

    def body
      @flushed = true
      if response.is_a?(HTTP::Response)
        response.body.to_s
      end
    end

    def json
      return @json if defined? @json
      begin
        @json = JSON.parse(body)
      rescue JSON::ParserError
        @json = nil
      end
    end

    def success?
      status < 400
    end

    def status
      response.status
    end

    def flush
      return if flushed
      if response.is_a?(HTTP::Response)
        response.flush
      end
    end
  end
end