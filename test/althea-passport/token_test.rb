require './test/test_helper'

class AltheaPassportTokenTest < Minitest::Test

  def test_connection
    token = AltheaPassport::Token.new('427d241d409210baa660614bc2508379')
    p token.key
    token.valid?
  end

end