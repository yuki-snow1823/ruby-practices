#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative './shot'
require_relative './frame'
require_relative './game'

class Bowling
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
    all_frames
  end
end

input_shots = ARGV[0].split(',')

game = Game.new
game.all_frames = Bowling.divide_all_shots_to_frames(input_shots)
game.play
