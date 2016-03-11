module AltheaPassport

  class SafeUser

    class << self

      def find(id, key)
        return EmptyUser.new if (id.blank? || key.blank?)

        user = User.find(id, key)
        if user.present?
          user
        else
          EmptyUser.new
        end
      end

    end

  end

end
