module AltheaPassport
  class Token
    class << self

      def validate(token)
        return nil unless token.present?

        begin
          response = AltheaPassport::Identifications.get('/identity/validate-token', token)
          return JSON.parse(response.body)['token']
        rescue => e
          return nil
        end
      end

      def invalidate(token)
        return unless token.present?

        begin
          AltheaPassport::Identifications.get('/identity/sign-out', token)
        rescue => e
          #TODO: Is just retrying sufficient?
          AltheaPassport::Identifications.get('/identity/sign-out', token)
        end
      end

    end
  end
end