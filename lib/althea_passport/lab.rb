module AltheaPassport
  class Lab

    attr_reader :id, :name, :time_zone, :current_user_role, :current_user_moderator, :trial_has_ended,
                :subdomain, :logo, :language

    def initialize(lab)
      @id = lab['lab_id']
      @name = lab['lab_name']
      @time_zone = lab['lab_time_zone']
      @current_user_role = lab['user_role']
      @current_user_moderator = lab['lab_moderator']
      @trial_has_ended = lab['trial_has_ended']
      @subdomain = lab['subdomain']
      @logo = lab['logo']
      @language = lab['language']
    end

    def present?
      id.present?
    end

    class << self
      def find(lab_id, token)
        begin
          response = Identifications.get("/labs/#{lab_id}/login?service=#{AltheaPassport.configuration.service_name}", token)
        rescue => e
          ##### TODO - NEED TO ADD API ERROR HANDLING ######
          p e.response
        end

        new(JSON.parse(response.body))
      end

      def logo(lab_id, token)
        begin
          response = Identifications.get("/labs/#{lab_id}/logo", token)
        rescue => e
          ##### TODO - NEED TO ADD API ERROR HANDLING ######
          p e.response
        end

        JSON.parse(response.body)['lab_logo']['logo']['url']
      end

      def create_sign_in(token)
        begin
          Identifications.post('/lab/sign_in', {}, token)
        rescue => e
          ##### TODO - NEED TO ADD API ERROR HANDLING ######
          p e.response
        end
      end

      # TODO: REMOVE THIS
      def validate_user_access(lab_id, token)
        begin
          response = Identifications.get("/labs/#{lab_id}/validate/user", token)
        rescue => e
          response = e.response
        end

        response.code
      end
    end

  end
end
