# frozen_string_literal: true

class Game
  attr_accessor :all_frames

  def initialize
    @all_frames
  end

  def play
    # frames = []
    # frames.each_with_index do |frame, index|
    #   game.total_score += if frame.frame_no == 9 && frame.is_strike
    #                         10 + frames[index + 1].shots_set[0] + frames[index + 1].shots_set[1]
    #                       elsif frame.frame_no != 10 && frame.is_strike && frames[index + 1].is_strike
    #                         10 + frames[index + 1].shots_set[0] + frames[index + 2].shots_set[0]
    #                       elsif frame.is_spare
    #                         10 + frames[index + 1].shots_set[0]
    #                       elsif frame.is_strike && frame.frame_no != 10
    #                         10 + frames[index + 1].shots_set[0] + frames[index + 1].shots_set[1]
    #                       else
    #                         frame.shots_set.sum
    #                       end
    # end

    # p game.total_score
  end
end
