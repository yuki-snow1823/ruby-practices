# frozen_string_literal: true

class Frame
  attr_accessor(:shots_set, :frame_score, :is_spare, :is_strike, :frame_no)

  def initialize(shots_set, frame_no)
    @is_strike = shots_set.include?('X')
    @shots_set = shots_set.map! { |shot| shot == 'X' ? 10 : shot.to_i }
    @frame_no = frame_no
    @frame_score = @shots_set.sum
    @is_spare = !@is_strike && frame_no != 10 && @shots_set[0] + @shots_set[1] == 10
  end
end
