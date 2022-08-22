class Frame
  attr_accessor(:shots_set, :frame_score)

  def initialize(shots_set)
    @shots_set = shots_set
    @frame_score = 0
  end

  def strike?
    @shots_set.include?('X')
  end

  def spare?
    @shots_set[0] + @shots_set[1] == 10
  end
end
