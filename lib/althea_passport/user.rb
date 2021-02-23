require 'active_support/core_ext/hash'

module AltheaPassport
  class User

    attr_reader :id, :name, :token, :initials, :photo_url, :roles, :thumbnail_url, :signature_url, :email, :trialing, :days_left_on_trial, :has_upgraded, :has_updated_settings
    attr_accessor :role

    def initialize(info, token)
      @id = info[:id]
      @name = info[:name]
      @email = info[:email]
      @token = token
      @initials = info[:initials]
      @photo_url = info[:photo].try(:[], :url)
      @roles = info[:roles]
      @thumbnail_url = info[:photo].try(:[], :thumb).try(:[], :url)
      @signature_url = info[:signature].try(:[], :url)
      @trialing = info[:trialing]
      @days_left_on_trial = info[:days_left_on_trial]
      @has_upgraded = info[:has_upgraded]
      @has_updated_settings = info[:has_updated_settings]
    end

    class << self
      def for_lab(lab_id, token)
        cache_key = "user/for_lab/lab-#{lab_id}"
        expires_in = 5.minutes

        # WHAT'S THE CORRECT ACTION IF AN EXCEPTION OCCURS? #
        begin
          response = AltheaPassport::Identifications.get("/users/lab/#{lab_id}/info", token, cache: { key: cache_key, expires_in: expires_in})
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
        cache_key = "user/find/user-#{token}"
        expires_in = 5.minutes

        response = AltheaPassport::Identifications.get("/user/info", token, cache: { key: cache_key, expires_in: expires_in})
        info = JSON.parse(response).deep_symbolize_keys[:user]
        new(info, token)
      end

      def find_by_id(id, token)
        cache_key = "user/find_by_id/user-#{id}-#{token}"
        expires_in = 5.minutes

        response = AltheaPassport::Identifications.get("/users/#{id}/info", token, cache: { key: cache_key, expires_in: expires_in})
        info = JSON.parse(response).deep_symbolize_keys[:user]
        new(info, token)
      end
    end

  end
end
