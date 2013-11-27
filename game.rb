require_relative 'deck'
require_relative 'player'
require_relative 'card'
require 'pry'

class Game
  def initialize
    @player = Player.new("Player")
    @dealer = Player.new("Dealer")
    @deck = Deck.new
    @continue_game = true
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
      @player.record[:wins] += 1
      ask_to_play_again
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

  def player_turn
    print "Hit or stand (H/S):"
    choice = gets.chomp.downcase
    if choice == 'h'
      new_card = @deck.next_card
      player_hand << new_card
      status(@player)
      player_turn
    else
      puts "The dealer's hand is #{dealer_hand[0].face} and #{dealer_hand[1].face}"
      @dealer.score_status
      dealer_turn
    end
  end

  def dealer_turn
    if @dealer.score >= 17
      puts "The dealer stands."
      game_result
    else
      dealer_hand << @deck.next_card
      status(@dealer)
      dealer_turn
    end
  end

  def game_result
    puts "================="
    puts "The player's final score is #{@player.score}."
    puts "The dealer's final score is #{@dealer.score}."
    if @player.score > @dealer.score
      puts "You win!"
      @player.record_result("wins")
      binding.pry
    elsif @player.score == @dealer.score
      puts "It's a push. No winner."
      @player.record_result("ties")
    else
      puts "You lose!"
      @player.record_result("losses")
    end
    ask_to_play_again
  end

  def ask_to_play_again
    puts 'Would you like to continue playing (Y/N):'
    input = gets.chomp.downcase
    if input == 'y'
      play
    else
      exit
    end
  end

  def final_results
    puts "Thank you for playing"
    @player.record
  end

  def play
    new_game = Game.new
    new_game.deal_hands
    new_game.player_turn
  end

  def status(player)
    player.last_card
    player.score_status
    if over_21?(player)
      lose(player)
    end
  end

  def over_21?(player)
    player.score > 21
  end

  def lose(player)
    puts "#{player.name} busts!"
    ask_to_play_again
  end
end

new_game = Game.new
new_game.play

