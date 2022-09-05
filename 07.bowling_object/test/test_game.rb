# frozen_string_literal: true
require_relative '../bowling'
require 'minitest/autorun'
require 'minitest/unit'

MiniTest::Unit.autorun

class TestBowling < MiniTest::Unit::TestCase

  def test_score
    process_args('X,X,X,X,X,X,X,X,X,X,X,X')
  end
end
