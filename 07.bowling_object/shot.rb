# frozen_string_literal: true

class Shot
  attr_accessor(:shots_each_frame)

  def initialize(shots)
    @frame_no = 1
    @shots_set = []
    @shots_each_frame = []
    divide_shots_to_frame(shots)
  end

  def divide_shots_to_frame(shots)
    shots.each_with_index do |shot, index|
      if shot == 'X' && @frame_no <= 9
        @shots_each_frame << [shot]
        @frame_no += 1
      elsif @frame_no == 10 && shots.length - 1 == index
        add_shots_set_to_frame(shot)
      elsif @frame_no == 10
        @shots_set << shot
      elsif shots.length - 1 == index
        add_shots_set_to_frame(shot)
      else
        @shots_set << shot
        add_two_shots_set_to_frame if @shots_set.length == 2
      end
    end
  end

  def add_shots_set_to_frame(shot)
    @shots_set << shot
    @shots_each_frame << @shots_set
  end

  def add_two_shots_set_to_frame
    @shots_each_frame << @shots_set
    @shots_set = []
    @frame_no += 1 
  end
end
