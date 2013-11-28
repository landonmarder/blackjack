class Player
  attr_accessor :hand, :name, :record, :money, :bet

  def initialize(name, money = nil)
    @name = name
    @hand = []
    @money = money
    @record = { 'wins' => 0, 'losses' => 0, 'ties' => 0 }
    @bet = 0
  end

  def score
    hand_score = 0
    @hand.each do |card|
      if card.rank != 'A'
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

  def record_result(result)
    @record[result] += 1
  end

  def display_score
    puts "Wins: #{@record['wins']} Losses: #{@record['losses']} Pushes: #{@record['ties']}"
    puts "Current Bank Account: $#{@money}"
  end

  def bet_money(gamble)
    @bet = gamble
    @money -= @bet
  end

  def win_money
    @money += @bet * 2
  end

  def push_money
    @money += @bet
  end
end
