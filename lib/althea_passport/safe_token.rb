module AltheaPassport

  class SafeToken

    class << self

      def set(key)
        token = key.blank? ? EmptyToken.new : Token.new(key)

        if token.valid?
          token
        else
          EmptyToken.new
        end
      end

    end

  end

end
