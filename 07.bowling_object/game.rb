# frozen_string_literal: true

class Game
  attr_accessor :frames

  def initialize(input_shots)
    @frames = []
    Frame.divide_all_shots_to_frames(input_shots, self)
  end

  def play
    total_score = 0
    10.times do |i|
      total_score += if i == 9
                       @frames.last.first_shot.score.to_i + @frames.last.second_shot.score.to_i + @frames.last.third_shot.score.to_i
                     elsif @frames[i].strike?
                       strike_calc(i)
                     elsif @frames[i].spare?
                       10 + @frames[i + 1].first_shot.score
                     else
                       @frames[i].first_shot.score + @frames[i].second_shot.score
                     end
    end
    p total_score
  end

  private

  def strike_calc(frame_count)
    if frame_count == 8 && @frames[frame_count + 1].strike?
      10 + @frames[frame_count + 1].first_shot.score + @frames[frame_count + 1].second_shot.score
    elsif @frames[frame_count + 1].strike?
      20 + @frames[frame_count + 2].first_shot.score
    else
      10 + @frames[frame_count + 1].first_shot.score + @frames[frame_count + 1].second_shot.score
    end
  end
end
