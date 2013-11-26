class Card
  attr_reader :suit, :rank
  def initialize(suit, rank)
    @suit = suit
    @rank = rank
    @value = self.value
  end

  def face
    @rank + @suit
  end

  def value
    if @rank == "A"
      [1,11]
    elsif @rank.to_i == 0
      10
    else
      @rank.to_i
    end
  end

end
