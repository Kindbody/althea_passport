module AltheaPassport
  class SafeUser

    class << self
      def find(token)
        return EmptyUser.new if token.blank?

        user = User.find(token)
        if user.present?
          user
        else
          EmptyUser.new
        end
      end
    end

  end
end
