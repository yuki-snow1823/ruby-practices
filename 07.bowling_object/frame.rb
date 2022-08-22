class Frame
  attr_accessor(:shots_set, :frame_score)

  def initialize(shots_set)
    @shots_set = shots_set
    @frame_score = 0
    @is_spare = shots_set.include?('X')
    @is_strike = shots_set[0] + shots_set[1] == 10
  end
end
