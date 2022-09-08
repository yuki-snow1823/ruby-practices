# frozen_string_literal: true

class Game
  attr_reader :frames

  def initialize(input_shots)
    @frames = Frame.divide_all_shots_to_frames(input_shots)
  end

  def play
    total_score = 0
    10.times do |i|
      total_score += if i == 9
                       @frames[i].shots.map(&:score).sum
                     elsif @frames[i].strike?
                       strike_calc_except_last_frame(i)
                     elsif @frames[i].spare?
                       10 + @frames[i + 1].first_shot.score
                     else
                       @frames[i].first_shot.score + @frames[i].second_shot.score
                     end
    end
    p total_score
  end

  private

  def strike_calc_except_last_frame(frame_count)
    if @frames[frame_count + 1].strike? && frame_count != 8
      20 + @frames[frame_count + 2].first_shot.score
    else
      10 + @frames[frame_count + 1].first_shot.score + @frames[frame_count + 1].second_shot.score
    end
  end
end
