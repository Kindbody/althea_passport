module AltheaPassport
  class Lab

    attr_reader :id, :name, :time_zone, :current_user_role

    def initialize(lab)
      @id = lab['lab_id']
      @name = lab['lab_name']
      @time_zone = lab['lab_time_zone']
      @current_user_role = lab['user_role']
    end

    def self.find(lab_id, token)
      begin
        response = Identifications.get("/labs/#{lab_id}/login/new?service_url=#{AltheaPassport.configuration.base_url}/saml/acs", token)
      rescue => e
        ##### TODO - NEED TO ADD API ERROR HANDLING ######
        p e.response
      end

      new(JSON.parse(response))
    end

    def logo(lab_id, token)
      begin
        response = Identifications.get("/labs/#{lab_id}/logo", token)
      rescue => e
        ##### TODO - NEED TO ADD API ERROR HANDLING ######
        p e.response
      end

      JSON.parse(response)['lab_logo']['logo']['url']
    end

    def validate_user_access(token)
      return 401 if token.blank?

      begin
        response = Identifications.get("/labs/#{@id}/validate/user", token)
      rescue => e
        response = e.response
      end

      response.code
    end

  end
end