# frozen_string_literal: true

class Frame
  attr_reader :first_shot, :second_shot, :third_shot
  attr_accessor :score

  def initialize(first_mark, second_mark = nil, third_mark = nil)
    @first_shot = Shot.new(first_mark)
    @second_shot = Shot.new(second_mark)
    @third_shot = Shot.new(third_mark)
    @score = 0
  end

  def strike?
    true if @first_shot.mark == 'X'
  end

  def spare?
    true if @first_shot.mark != 'X' && @first_shot.score + @second_shot.score == 10
  end
end
