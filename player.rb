class Player
  attr_accessor :hand, :name

  def initialize(name)
    @name = name
    @hand = []
  end

  def score
    hand_score = 0
    @hand.each do |card|
      if card.rank != "A"
        hand_score += card.value
      elsif (hand_score) > 10
        hand_score += 1
      else
        hand_score += 11
      end
    end
    hand_score
  end

  def last_card
    puts "The #{@name} was dealt a #{@hand.last.face}"
  end

  def score_status
    puts "The #{@name}'s current score is #{score}."
  end
end
