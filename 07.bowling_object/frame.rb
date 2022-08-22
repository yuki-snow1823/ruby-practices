class Frame
  attr_accessor :point

  def initialize(shots_pair)
    @shots_pair = shots_pair
  end

  def strike?
    @shots_pair == ['X']
  end
end
