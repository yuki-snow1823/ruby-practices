require './shot'
require './frame'
require './game'

input_shots = gets.chomp!.split(',')
shots = Shot.new(input_shots)
frames = []

shots.shots_each_frame.each_with_index do |shots_set, index|
  frames << Frame.new(shots_set, index + 1)
end

game = Game.new

frames.each_with_index do |frame, index|
  p game.total_score
  game.total_score += if frame.is_strike && frame.frame_no < 10 && frames[index + 1].shots_set.include?('X')
                        # 9フレーム目にストライクを出した場合
                        if frame.frame_no == 9 && frame.shots_set == ['X']
                          # Xを10に変換するメソッド必要
                          10 + frame[index + 1].shots_set[0] + frame[index + 1].shots_set[0]
                        else
                          20
                        end
                      elsif frame.is_strike && frame.frame_no < 10
                        frames[index + 1].shots_set.sum(&:to_i) + 10
                      elsif frame.is_spare && frame.frame_no < 10
                        10 + frames[index + 1].shots_set[0]
                      else
                        frame.shots_set.sum(&:to_i)
                      end
end

p game.total_score
