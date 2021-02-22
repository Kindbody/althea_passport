require './test/test_helper'

class AltheaPassportTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil AltheaPassport::VERSION
  end

  def test_it_allows_configuration
    AltheaPassport.configure do |config|
      config.base_url = 'base_url'
      config.idp_url = 'idp_url'
      config.jwt_secret_key = 'jwt_secret_key'
    end

    assert AltheaPassport.configuration.base_url = 'base_url'
    assert AltheaPassport.configuration.idp_url = 'idp_url'
    assert AltheaPassport.configuration.jwt_secret_key = 'jwt_secret_key'
  end
end
