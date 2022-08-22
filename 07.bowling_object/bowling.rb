require './shot'
require './frame'
require './game'

input_shots = gets.chomp!.split(',')
shots = Shot.new(input_shots)
game = Game.new

shots_each_frame = shots.shots_each_frame

is_before_frame_spare = false
is_before_frame_strike = false

shots_each_frame.each do |shots_pair|
  frame = Frame.new(shots_pair)
  p frame.shots_pair
  if frame.strike?
    game.total_score += 10
  else
    # ストライクだと0になる
    game.total_score += (frame.shots_pair[0].to_i + frame.shots_pair[1].to_i)
  end
  game.total_score += (frame.shots_pair[0].to_i + frame.shots_pair[1].to_i) if is_before_frame_strike
  is_before_frame_strike = frame.strike?

  # ストライクだと0になる
  game.total_score += frame.shots_pair[0].to_i if is_before_frame_spare
  is_before_frame_spare = frame.spare?
  p game.total_score
end

puts game.total_score
