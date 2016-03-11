require './test/test_helper'

class AltheaPassportLabTest < Minitest::Test
  def test_exists
    assert AltheaPassport::Lab
  end
end