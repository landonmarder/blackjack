require_relative 'deck'
require_relative 'dealer'
require_relative 'player'
require_relative 'card'
require 'pry'

class Game
  def initialize
    @player = Player.new
    @dealer = Dealer.new
    @deck = Deck.new
    deal_hands
    # hit_or_stand
  end

  def deal_hands
    2.times do
      player_hand << @deck.next_card
    end
    2.times do
      dealer_hand << @deck.next_card
    end

    display_hand(player_hand)
    puts "Player's current score is: #{@player.score}"
    puts "Dealer was dealt: #{dealer_hand.last.face} and a mystery card"

    if @player.score == 21
      puts "Blackjack! You win!"
      abort
    end
  end

  def player_hand
    @player.hand
  end

  def dealer_hand
    @dealer.hand
  end

  def display_hand(hand)
    print "The player was dealt: "
    hand.each do |card|
      print "#{card.face} "
    end
    print "\n"
  end
end

Game.new
