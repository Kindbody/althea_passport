require './test/test_helper'

class UserTest < Minitest::Test
  def test_exists
    assert AltheaPassport::User
  end
end
