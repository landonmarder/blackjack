class Player
  attr_accessor :hand

  def initialize
    @hand = []
  end

  def score
    hand_score = 0
    @hand.each do |card|
      if card.rank != "A"
        hand_score += card.value
      elsif (hand_score + card.value[1]) > 21
        hand_score += card.value[0]
      else
        hand_score += card.value[1]
      end
    end
    hand_score
  end
end
