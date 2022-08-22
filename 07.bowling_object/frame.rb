class Frame
  attr_accessor :shots_pair

  def initialize(shots_pair)
    @shots_pair = shots_pair
  end

  def strike?
    @shots_pair == ['X']
  end

  def spare?
    @shots_pair.map(&:to_i).sum == 10
  end
end
