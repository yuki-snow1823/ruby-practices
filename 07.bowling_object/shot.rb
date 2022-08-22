# frozen_string_literal: true

class Shot
  attr_accessor(:shots_each_frame)

  def initialize(shots)
    shots_set = []
    frame_count = 1
    @shots_each_frame = []
    shots.each_with_index do |shot, index|
      # ストライクかつ最後のフレーム以外はフレーム＝ストライク
      if shot == 'X' && frame_count <= 9
        @shots_each_frame << [shot]
        frame_count += 1
        # フレームが最後ではなくショットが最後の時
      elsif shots.length - 1 == index
        shots_set << shot
        @shots_each_frame << shots_set
        # 最後のショット以降はまとめてフレームに値を追加していく（2つか3つか分からないため）
      elsif frame_count == 10
        shots_set << shot
      else
        # 最後のフレーム以外かつストライクでない場合は2つショットが揃ったらフレームに追加
        shots_set << shot
        if shots_set.length == 2
          @shots_each_frame << shots_set
          shots_set = []
          frame_count += 1
        end
      end
    end
  end
end
