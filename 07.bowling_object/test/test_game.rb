# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/unit'
require_relative '../Game'
require_relative '../shot'
require_relative '../frame'

MiniTest::Unit.autorun

class TestBowling < MiniTest::Unit::TestCase
  def test_last_frame_and_just_before_are_all_strikes
    input_shots = '6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,X,X'
    game = Game.new(input_shots)
    assert_equal(164, game.play)
  end

  def test_across_the_frame_continuous_strikes
    input_shots = '0,10,1,5,0,0,0,0,X,X,X,5,1,8,1,0,4'
    game = Game.new(input_shots)
    assert_equal(107, game.play)
  end

  def test_last_frame_and_the_just_before_frame_are_strike
    input_shots = '6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,0,0'
    game = Game.new(input_shots)
    assert_equal(134, game.play)
  end

  def test_last_frame_has_score_and_the_just_before_frame_are_strike
    input_shots = '6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,1,8'
    game = Game.new(input_shots)
    assert_equal(134, game.play)
  end

  def test_all_strike
    input_shots = 'X,X,X,X,X,X,X,X,X,X,X,X'
    game = Game.new(input_shots)
    assert_equal(300, game.play)
  end
end
