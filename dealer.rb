require_relative 'player'
class Dealer < Player
  attr_accessor :hand

  def initialize
    @hand = []
  end
end
