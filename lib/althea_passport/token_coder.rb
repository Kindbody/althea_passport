require 'jwt'
require 'active_support/core_ext/hash'

module AltheaPassport
  class TokenCoder

    class << self

      def encode(payload, library = JWT)
        library.encode(payload, secret_key, algorithm)
      end

      def decode(token, options = {}, library = JWT)
        decoded_token = library.decode(token, secret_key, true, { algorithm: algorithm }.merge(options))
        decoded_token.first.deep_symbolize_keys
      end

      def secret_key
        AltheaPassport.configuration.jwt_secret_key
      end

      def algorithm
        'HS256'
      end

    end

  end
end
