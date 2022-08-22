class Frame
  attr_accessor(:shots_set, :frame_score, :is_spare, :is_strike, :frame_no)

  def initialize(shots_set, frame_no)
    @shots_set = shots_set
    @frame_no = frame_no
    @frame_score = 0
    @is_spare = shots_set.include?('X')
    @is_strike = shots_set[0] == 'X' || (shots_set[0] + shots_set[1] == 10)
  end
end
