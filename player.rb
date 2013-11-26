class Player
  attr_accessor :hand

  def initialize
    @hand = []
  end

  def score
    score = 0
    @hand.each do |card|
      if !card.rank == "A"
        score += card.value
      elsif (score + card.value[1]) > 21
        score += card.value[0]
      else
        score += card.value[1]
      end
    end
    score
  end
end
