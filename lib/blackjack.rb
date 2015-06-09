#!/usr/bin/env ruby
require 'pry'

SUITS = ["spades", "clubs", "hearts", "diamonds"]
VALUES = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']

class PlayingCard
attr_reader :rank, :suit
attr_accessor :card_value

  def initialize(rank, suit)
    @rank = rank
    @card_value = value_key[rank]
    @suit = suit
  end

  def value_key
    {
      "2" => 2,
      "3" => 3,
      "4" => 4,
      "5" => 5,
      "6" => 6,
      "7" => 7,
      "8" => 8,
      "9" => 9,
      "10" => 10,
      "J" => 10,
      "Q" => 10,
      "K" => 10,
      "A" => 11,
    }
  end

end

class Deck
    attr_reader :draw, :collection

  def initialize
    #Creates an array of PlayingCard objects
    @collection = build_deck
    @draw = draw
  end

  def build_deck
    collection = []
    SUITS.each do |suit|
      VALUES.each do |value|
        collection << PlayingCard.new(value, suit)
      end
    end
    collection.shuffle!
  end

  def draw!
    @collection.pop
    #return a card and remove it from @collection
  end

end

class Hand
attr_accessor :game_deck, :player_hand, :dealer_hand, :player_score

  def initialize
    @game_deck = Deck.new
    @player_hand = [@game_deck.draw!, @game_deck.draw!]
    @dealer_hand = [@game_deck.draw!, @game_deck.draw!]
    # @player_score = hand_value
  end

  def player_hand_value
    hand_total = 0
    sorted_hand = @player_hand.sort_by{|card| card.card_value}
    sorted_hand.each do |card|
      if card.card_value == 11 && (hand_total + card.card_value) < 21
        hand_total += 1
      else
      hand_total += card.card_value
      end
    end
    return hand_total
  end

  def dealer_hand_value
    hand_total = 0
    @dealer_hand.each do |value|
      hand_total += value.card_value
    end
    return hand_total
  end



  def self.play
    blackjack = Hand.new
    puts "Welcome to Blackjack! Daddy needs a new pair of shoes!"
    blackjack.player_hand.each do |attribute|
      puts "Player was delt: #{attribute.rank} #{attribute.suit}"
    end

    until blackjack.player_hand_value >= 21
      puts "Player score: #{blackjack.player_hand_value} "
      print "Hit or stand (H/S):"
      player_choice = gets.chomp.downcase
      case player_choice
        when "h"
          blackjack.player_hand << blackjack.game_deck.draw!
          blackjack.player_hand.each do |attribute|
            puts "Player was delt: #{attribute.rank} #{attribute.suit}"
          end

        when "s"
          puts "Player score: #{blackjack.player_hand_value}"
          puts "Player stands."
          break
      end
    end
    if blackjack.player_hand_value > 21
      puts "Player score: #{blackjack.player_hand_value}"
      puts "BUST! YOU LOSE :("
      exit
    end


    blackjack.dealer_hand.each do |attribute|
      puts "Dealer was dealt:#{attribute.rank} #{attribute.suit}"
    end
    puts "Dealer score: #{blackjack.dealer_hand_value}"

    while blackjack.dealer_hand_value <= 17
      puts "Dealer hits."
      blackjack.dealer_hand << blackjack.game_deck.draw!
      blackjack.dealer_hand.each{|attribute| puts "Dealer was delt: #{attribute.rank} #{attribute.suit}" }
      puts "Dealer score: #{blackjack.dealer_hand_value}"
    end

    if blackjack.player_hand_value == 21 && blackjack.dealer_hand_value !=21
        puts "YOU WIN! KACHING!"
      elsif blackjack.dealer_hand_value == 21 && blackjack.player_hand_value !=21
        puts "House wins!"
      elsif blackjack.player_hand_value > blackjack.dealer_hand_value && blackjack.player_hand_value < 21
        puts "YOU WIN! KACHING!"
      elsif blackjack.dealer_hand_value > blackjack.player_hand_value && blackjack.dealer_hand_value < 21
        puts "House wins!"
      else
        puts "Dealer busts, you win!"
    end

  end
end



Hand.play
