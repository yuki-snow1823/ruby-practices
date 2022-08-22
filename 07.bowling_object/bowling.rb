require './shot'
require './frame'
require './game'

input_shots = gets.chomp!.split(',')
shots = Shot.new(input_shots)
frames = []

shots.shots_each_frame.each_with_index do |shots_set, index|
  frames << Frame.new(shots_set, index + 1)
end

game = Game.new(frames)

game.frames.each_with_index do |frame, index|
  frame.frame_score += if frame.is_strike && frame.frame_no < 10 && frames[index + 1].shots_set == ['X']
                         20
                       elsif frame.is_strike && frame.frame_no < 10
                         frames[index + 1].shots_set.sum(&:to_i) + 10
                       elsif frame.is_spare && frame.frame_no < 10
                         10 + frames[index + 1].shots_set[0]
                       else
                         frame.shots_set.sum(&:to_i)
                       end
end

p game.frames[0].frame_score
