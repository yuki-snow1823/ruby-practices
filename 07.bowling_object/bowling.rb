require './shot'

input_shots = gets.chomp!.split(',')
shots = Shot.new(input_shots)
shots.shots_each_frame
