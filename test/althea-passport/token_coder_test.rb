require './test/test_helper'

class TokenCoderTest < Minitest::Test

  def test_can_encode_token
    AltheaPassport.configuration.jwt_secret_key = 'secret_key'

    token = AltheaPassport::TokenCoder.encode({ test: 'test' })
    assert token == 'eyJhbGciOiJIUzI1NiJ9.eyJ0ZXN0IjoidGVzdCJ9.0Irh0fOfliLnviOLXbVxjGgk6yTYzzqHOayDTTqm22c'
  end

  def test_can_decode_token
    AltheaPassport.configuration.jwt_secret_key = 'secret_key'

    token = AltheaPassport::TokenCoder.decode('eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0ZXN0IjoidGVzdCJ9.Ia9c1fjT9S7x_LyTrlriyjnu7EoPAeCfcWJnQjJ2eV8')

    assert token == {test: "test"}
  end

end