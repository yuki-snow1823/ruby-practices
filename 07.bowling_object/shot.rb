# frozen_string_literal: true

class Shot
  attr_accessor(:shots_each_frame)

  def initialize(shots)
    shot_pair = []
    @shots_each_frame = []
    # TODO: mapに書き換えたい
    shots.each do |shot|
      if shot == 'X'
        @shots_each_frame << [shot]
      else
        shot_pair << shot
        if shot_pair.length == 2
          @shots_each_frame << shot_pair
          shot_pair = []
        end
      end
    end
  end
end
