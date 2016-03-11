module AltheaPassport

  class Token
    attr_accessor :key, :status

    def initialize(key)
      @status = 401
      @key = fresh(key)
      self.freeze
    end

    def valid?
      status == 200
    end

    def invalid?
      status != 200
    end

    private

    def fresh(key)
      begin
        response = AltheaPassport::Identifications.get("/token/validate", key)
      rescue => e
        response = e.response
      end

      if response.code == 200
        new_key = JSON.parse(response)["token"]
      elsif response.code == 401
        new_key = nil
      end

      self.status = response.code

      new_key
    end
  end

end