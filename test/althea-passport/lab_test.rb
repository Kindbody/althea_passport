require './test/test_helper'

class LabTest < Minitest::Test
  def test_exists
    assert AltheaPassport::Lab
  end
end
