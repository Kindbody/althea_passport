require 'ruby-saml'
require 'active_support/core_ext/hash'

module AltheaPassport
  class User

    attr_reader :id, :name, :token, :initials, :photo_url, :thumbnail_url, :signature_url
    attr_accessor :role

    def initialize(info, token)
      @id = info[:id]
      @name = info[:name]
      @token = token
      @initials = info[:initials]
      @photo_url = info[:photo].try(:[], :url)
      @thumbnail_url = info[:photo].try(:[], :thumb).try(:[], :url)
      @signature_url = info[:signature].try(:[], :url)
    end

    class << self
      def for_lab(lab_id, token)
        # WHAT'S THE CORRECT ACTION IF AN EXCEPTION OCCURS? #
        begin
          response = AltheaPassport::Identifications.get("/users/lab/#{lab_id}/info", token)
        rescue => e
          ###### NEED TO ADD API ERROR HANDLING ######
          p e.response
        end

        user_info_hash = {}

        JSON.parse(response)['labUsersInfo'].each do |user_info|
          symbolized_info = user_info.deep_symbolize_keys
          user_info_hash[user_info['id']] = new(symbolized_info, token)
        end

        user_info_hash
      end

      def find(token)
        response = AltheaPassport::Identifications.get("/user/info", token)
        info = JSON.parse(response).deep_symbolize_keys[:user]
        new(info, token)
      end
    end

    def self.get_saml_settings
      base_url = AltheaPassport.configuration.base_url
      idp_url = AltheaPassport.configuration.idp_url
      saml_fingerprint = AltheaPassport.configuration.saml_fingerprint
      saml_format = AltheaPassport.configuration.saml_format

      settings = OneLogin::RubySaml::Settings.new
      settings.assertion_consumer_service_url        = "#{base_url}/saml/acs"
      settings.assertion_consumer_logout_service_url = "#{base_url}/saml/logout"
      settings.issuer                                = "#{base_url}/saml/acs"
      settings.idp_entity_id                         = "#{idp_url}/saml/auth"
      settings.idp_sso_target_url                    = "#{idp_url}/saml/auth"
      settings.idp_slo_target_url                    = "#{idp_url}/saml/logout"
      settings.idp_cert_fingerprint                  = saml_fingerprint
      settings.name_identifier_format                = saml_format
      settings
    end

  end
end