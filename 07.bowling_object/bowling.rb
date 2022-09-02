#!/usr/bin/env ruby
# frozen_string_literal: true

require './shot'
require './frame'
require './game'

class BowlingApp
  def play_game()
    
  end

  def create_all_shots(input_shots)
    input_shots.map { |shot| Shot.new(shot) }
  end


  game = Game.new
  pp game.create_all_shots(input_shots)

  # game呼び出して終了みたいにしたい

  # shots.shots_each_frame.each_with_index do |shots_set, index|
  #   frames << Frame.new(shots_set, index + 1)
  # end

  frames = []

  frames.each_with_index do |frame, index|
    game.total_score += if frame.frame_no == 9 && frame.is_strike
                          10 + frames[index + 1].shots_set[0] + frames[index + 1].shots_set[1]
                        elsif frame.frame_no != 10 && frame.is_strike && frames[index + 1].is_strike
                          10 + frames[index + 1].shots_set[0] + frames[index + 2].shots_set[0]
                        elsif frame.is_spare
                          10 + frames[index + 1].shots_set[0]
                        elsif frame.is_strike && frame.frame_no != 10
                          10 + frames[index + 1].shots_set[0] + frames[index + 1].shots_set[1]
                        else
                          frame.shots_set.sum
                        end
  end

  p game.total_score
end

input_shots = ARGV[0].split(',')
play_game(input_shots)
