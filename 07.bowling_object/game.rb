# frozen_string_literal: true

class Game
  attr_accessor :all_frames

  def initialize
    @all_frames = []
  end

  def play
    10.times do |i|
      @all_frames[i].score = if i == 9
                               last_frame_calc
                             elsif @all_frames[i].spare?
                               10 + @all_frames[i + 1].first_shot.score
                             elsif @all_frames[i].strike?
                               10 + @all_frames[i + 1].first_shot.score + @all_frames[i + 1].second_shot.score
                             else
                               @all_frames[i].first_shot.score + @all_frames[i].second_shot.score
                             end
    end
    p @all_frames.sum(&:score)
  end

  private

  def last_frame_calc
    if @all_frames.last.strike?
      10 + @all_frames.last.second_shot.score + @all_frames.last.third_shot.score
    elsif @all_frames.last.spare?
      10 + @all_frames.last.third_shot.score
    end
  end
end
