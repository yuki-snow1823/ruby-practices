class Frame
  attr_accessor(:shots_set, :frame_score, :is_spare, :is_strike, :frame_no)

  def initialize(shots_set, frame_no)
    @shots_set = shots_set
    @frame_no = frame_no
    @frame_score = 0
    @is_spare = shots_set[0] + shots_set[1] == 10
    @is_strike = shots_set.include?('X')
  end
end
