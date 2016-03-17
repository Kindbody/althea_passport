module AltheaPassport
  class EmptyUser

    attr_writer :role

    def first_name
      nil
    end

    def present?
      false
    end

  end
end
