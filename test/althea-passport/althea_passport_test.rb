require './test/test_helper'

class AltheaPassportTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil AltheaPassport::VERSION
  end

  def test_it_allows_configuration
    AltheaPassport.configure do |config|
      config.base_url = 'base_url'
      config.idp_url = 'idp_url'
      config.saml_fingerprint = 'saml_fingerprint'
      config.saml_format = 'saml_format'
    end

    assert AltheaPassport.configuration.base_url = 'base_url'
    assert AltheaPassport.configuration.idp_url = 'idp_url'
    assert AltheaPassport.configuration.saml_fingerprint = 'saml_fingerprint'
    assert AltheaPassport.configuration.saml_format = 'saml_format'
  end
end
