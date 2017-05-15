module AltheaPassport
  class EmptyUser

    attr_reader :id, :name, :token, :initials, :photo_url, :thumbnail_url, :signature_url, :trialing, :days_left_on_trial, :has_upgraded
    attr_writer :role

    def first_name
      nil
    end

    def present?
      false
    end

  end
end
