require 'minitest/autorun'
require 'minitest/unit'

MiniTest::Unit.autorun

class TestBowling < MiniTest::Unit::TestCase
  require '../bowling'
  def test_score
    process_args('X,X,X,X,X,X,X,X,X,X,X,X')
  end
end
