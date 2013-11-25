#!/usr/bin/env ruby
# encoding: UTF-8

SUITS = ['♠', '♣', '♥', '♦']
VALUES = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']

def build_deck
  @deck = []

  SUITS.each do |suit|
    VALUES.each do |value|
      @deck.push(value + suit)
    end
  end

  @deck.shuffle!
end

@deck = build_deck
@player_cards = []
@dealer_cards = []

def next_card
    @next_card = @deck.pop
end

def deal_hands
  2.times do
    @player_cards << next_card
  end
  2.times do
    @dealer_cards << next_card
  end
  puts "Player was dealt #{@player_cards.join(' and ')}"
  calculate(@player_cards)
  if @score == 21
    puts "Blackjack! You win!"
    abort
  end
  puts "Dealer was dealt #{@dealer_cards.last}"
end

def start_game
  build_deck
  deal_hands
  hit_or_stand
end

def calculate hand
  @score = 0
  hand.each do |card|
    if card.to_i > 0
      @score += card.to_i
    elsif !card.start_with?("A")
      @score += 10
    elsif (@score + 11) > 21
      @score += 1
    else
      @score += 11
    end
  end
  return @score
end

def dealer_turn
  puts "The dealer's current score is #{calculate(@dealer_cards)}."
  if @score > 21
    puts "Dealer busts! You win!"
    abort
  elsif @score < 17
    @dealer_cards << next_card
    puts "The dealer was dealt a #{@dealer_cards.last}"
    dealer_turn
  else
    puts "The player's final score is #{calculate(@player_cards)}."
    puts "The dealer's final score is #{calculate(@dealer_cards)}."
    if calculate(@player_cards) > calculate(@dealer_cards)
      puts "You win!"
    elsif calculate(@player_cards) == calculate(@dealer_cards)
      puts "It's a push. No winner."
    else
      puts "You lose!"
    end
  end
end


def hit_or_stand
  print "Hit or stand (H/S):"
  choice = gets.chomp.downcase
  if choice == 'h'
    @player_cards << next_card
    puts "You were dealt a #{@player_cards.last}"
      puts "The player's current score is #{calculate(@player_cards)}."
    if @score > 21
      puts "You Lose!"
      abort
    else
      hit_or_stand
    end
  else
    dealer_turn
  end
end

start_game

