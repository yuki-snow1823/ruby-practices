# frozen_string_literal: true

class Frame
  attr_reader :first_shot, :second_shot, :third_shot

  def initialize(first_mark, second_mark = nil, third_mark = nil)
    @first_shot = Shot.new(first_mark)
    @second_shot = Shot.new(second_mark)
    @third_shot = Shot.new(third_mark)
  end

  def self.divide_all_shots_to_frames(input_shots, game)
    shots = input_shots.split(',')
    game.frames = Array.new(10) do |i|
      if i == 9
        Frame.new(*shots)
      elsif shots.first == 'X'
        Frame.new(shots.shift)
      else
        Frame.new(shots.shift, shots.shift)
      end
    end
  end

  def strike?
    @first_shot.mark == 'X'
  end

  def spare?
    @first_shot.mark != 'X' && @first_shot.score + @second_shot.score == 10
  end
end
