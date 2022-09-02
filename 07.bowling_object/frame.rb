# frozen_string_literal: true

class Frame
  # attr_accessor(:shots_set, :frame_score, :is_spare, :is_strike, :frame_no)

  # def initialize(shots_set, frame_no)
  #   @is_strike = shots_set.include?('X')
  #   @shots_set = shots_set.map! { |shot| shot == 'X' ? 10 : shot.to_i }
  #   @frame_no = frame_no
  #   @frame_score = @shots_set.sum
  #   @is_spare = !@is_strike && frame_no != 10 && @shots_set[0] + @shots_set[1] == 10
  # end

  attr_reader :first_shot, :second_shot, :third_shot

  def initialize(first_mark, second_mark = nil, third_mark = nil)
    @first_shot = Shot.new(first_mark)
    @second_shot = Shot.new(second_mark)
    @third_shot = Shot.new(third_mark)
  end

  def score
  end
end
