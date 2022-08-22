require './shot'
require './frame'
require './game'

input_shots = gets.chomp!.split(',')
shots = Shot.new(input_shots)
game = Game.new

shots_each_frame = shots.shots_each_frame

p shots_each_frame

shots_each_frame.each do |shots_pair|
  frame = Frame.new(shots_pair)
  game.total_score += 10 if frame.strike?
  p frame.spare?
end

puts game.total_score
