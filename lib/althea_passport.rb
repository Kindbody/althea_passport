require "althea_passport/version"
require "althea_passport/configuration"
require "althea_passport/empty_token"
require "althea_passport/empty_user"
require "althea_passport/identifications"
require "althea_passport/lab"
require "althea_passport/safe_token"
require "althea_passport/safe_user"
require "althea_passport/token"
require "althea_passport/user"

module AltheaPassport

  class << self

    attr_writer :configuration

    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end

  end

end

