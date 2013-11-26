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
    display_hand(dealer_hand)

    # puts "Player was dealt #{player_hand.each {|card| card.face}}"
    puts "Player's current score is: #{@player.score}"
    if @player.score == 21
      puts "Blackjack! You win!"
      abort
    end
    # puts "Dealer was dealt #{dealer_hand.last}"
    # puts "Dealer was dealt #{dealer_hand.join(' and ')}"
    puts "Dealer's current score is: #{@dealer.score} "
    binding.pry
  end

  def player_hand
    @player.hand
  end

  def dealer_hand
    @dealer.hand
  end

  def display_hand(hand)
    hand.each do |card|
      puts card.face
    end
  end
end

Game.new
