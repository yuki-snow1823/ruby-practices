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

p game.frames[0].shots_set

# shots_each_frame.each_with_index do |shots_set, index|
#   p frame.shots_set

# 最後X出すとエラーになる その対応が必要
#   game.total_score += if frame.strike?
#                         10
#                       else
#                         (frame.shots_set[0].to_i + frame.shots_set[1].to_i)
#                       end

#  p game.shots_each_frame

#   if is_before_frame_strike && frame.strike?
#     game.total_score += 10
#     game.total_score += if index < 9 && shots_each_frame[index + 1][0] == 'X'
#                           10
#                         elsif index < 9
#                           shots_each_frame[index + 1][0].to_i
#                         else
#                           0
#                         end
#   elsif is_before_frame_strike
#     game.total_score += (frame.shots_set[0].to_i + frame.shots_set[1].to_i)
#   end
#   is_before_frame_strike = frame.strike?

#   if is_before_frame_spare && frame.strike?
#     game.total_score += 10
#   elsif is_before_frame_spare
#     game.total_score += frame.shots_set[0].to_i
#   end
#   is_before_frame_spare = frame.spare?

#   p game.total_score
# end

# puts game.total_score
