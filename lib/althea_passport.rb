require "althea_passport/version"
require "althea_passport/persistent_http_client"
require "althea_passport/http_client"
require "althea_passport/http_client_response"
require "althea_passport/configuration"
require "althea_passport/empty_user"
require "althea_passport/identifications"
require "althea_passport/lab"
require "althea_passport/safe_user"
require "althea_passport/token"
require "althea_passport/token_coder"
require "althea_passport/user"
require "althea_passport/api_base"
require "althea_passport/api_exception"
require "althea_passport/insights"

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

