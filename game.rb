require_relative 'deck'
require_relative 'player'
require_relative 'card'
require 'pry'

class Game
  def initialize
    @player = Player.new("Player", 10)
    @dealer = Player.new("Dealer")
    @deck = Deck.new
    @continue_game = true
  end

  def deal_hands
    player_bet(@player)
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
      @player.record_result("wins")
      puts "Blackjack! You win!"
      ask_to_play_again
    end
  end

  def player_bet(player)
    if @player.money == 0
      puts 'Sorry, you are out of money :('
      display_game_info
      exit
    else
      puts "#{player.name} you have $#{player.money}. How much would you like to bet?"
      puts "(Casino Rules: You must bet in full dollar amounts.)"
      print '$'
      input = gets.chomp.to_i
      if input <= player.money
        player.bet_money(input)
      else
        puts "You don't have enough money for that bet!"
        player_bet(player)
      end
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
      puts "You win $#{@player.bet}!"
      @player.record_result("wins")
      @player.win_money
    elsif @player.score == @dealer.score
      puts "It's a push. No winner."
      @player.record_result("ties")
      @player.push_money
    else
      puts "You lose $#{@player.bet}"
      @player.record_result("losses")
    end
    ask_to_play_again
  end

  def ask_to_play_again
    display_game_info
    puts 'Would you like to continue playing (Y/N):'
    input = gets.chomp.downcase
    if input == 'y'
      play
    else
      exit
    end
  end

  def display_game_info
    puts "Game Data"
    @player.display_score
  end

  def final_results
    puts "Thank you for playing"
    @player.record
  end

  def play
    @deck = Deck.new
    player_hand.clear
    dealer_hand.clear
    deal_hands
    player_turn
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
    if player.name == "Dealer"
      puts "You win $#{@player.bet}!"
      @player.record_result("wins")
      @player.win_money
    else
      @player.record_result("losses")
    end
    ask_to_play_again
  end
end

new_game = Game.new
new_game.play

