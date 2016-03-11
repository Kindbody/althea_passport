require './test/test_helper'

class AltheaPassportUserTest < Minitest::Test
  def test_exists
    assert AltheaPassport::User
  end
end