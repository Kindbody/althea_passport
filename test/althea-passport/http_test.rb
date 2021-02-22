require './test/test_helper'

class HttpTest < Minitest::Test
  def test_exists
    response = AltheaPassport::ApiBase.call_althea_api(:get, nil, "https://www.google.com")
    assert response.success?
  end
end
