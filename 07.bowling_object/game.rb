# frozen_string_literal: true

class Game
  attr_accessor :total_score
  attr_accessor :frames

  def initialize(frames)
    @frames = frames
    @total_score = 0
  end
end
