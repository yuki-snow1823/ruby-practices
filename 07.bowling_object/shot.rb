# frozen_string_literal: true

class Shot
  attr_accessor(:shots_each_frame)

  def initialize(shots)
    shot_set, @shots_each_frame = []
    shots.each_with_index do |shot, index|
      if shot == 'X' && index != 9
        @shots_each_frame << [shot]
      else
        shot_set << shot
        if index > 9
          shot_set << shot
          shot_set = []
        # 最後のフレームはまとめて値を追加する（2つか3つか分からないため）
        elsif shots.length - 1 == index
          @shots_each_frame << shot_set
        end
      end
    end
  end
end
