module AltheaPassport

  class User

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

      def find(user_id, token)
        response = AltheaPassport::Identifications.get("/users/#{user_id}/info", token)
        info = JSON.parse(response).deep_symbolize_keys[:user]
        new(info, token)
      end

    end

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

    def self.get_saml_settings
      settings = OneLogin::RubySaml::Settings.new
      settings.assertion_consumer_service_url = "#{ENV['base_url']}/saml/acs"
      settings.assertion_consumer_logout_service_url = "#{ENV['base_url']}/saml/logout"
      settings.issuer                         = "#{ENV['base_url']}/saml/acs"
      settings.idp_entity_id                  = "#{ENV['idp_url']}/saml/auth"
      settings.idp_sso_target_url             = "#{ENV['idp_url']}/saml/auth"
      settings.idp_slo_target_url             = "#{ENV['idp_url']}/saml/logout"
      settings.idp_cert_fingerprint           = ENV['SAML_FINGERPRINT']
      settings.name_identifier_format         = ENV['SAML_FORMAT']
      settings
    end

  end

end