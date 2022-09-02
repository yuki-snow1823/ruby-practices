#!/usr/bin/env ruby
# frozen_string_literal: true

require './shot'
require './frame'
require './game'

class BowlingApp
  def self.divide_all_shots_to_frames(input_shots)
    all_frames = []
    10.times do |i|
      all_frames << if i == 9 && (input_shots.first == 'X' || input_shots.first.to_i + input_shots[1].to_i == 10)
                      Frame.new(input_shots.shift, input_shots.shift, input_shots.shift)
                    elsif input_shots.first == 'X'
                      Frame.new(input_shots.shift)
                    else
                      Frame.new(input_shots.shift, input_shots.shift)
                    end
    end
    pp all_frames
  end
end

game = Game.new
game.all_frames

input_shots = ARGV[0].split(',')
game.all_frames = BowlingApp.divide_all_shots_to_frames(input_shots)
game.all_frames # なぜか10が入る
game.play
