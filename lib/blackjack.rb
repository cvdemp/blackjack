#!/usr/bin/env ruby
require 'pry'

SUITS = ["spades", "clubs", "hearts", "diamonds"]
VALUES = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']

class PlayingCard
attr_reader :rank, :suit, :card_value
  def initialize(rank, suit)
    @rank = rank
    @card_value = value_key[rank]
    @suit = suit
  end

  def face_card?
    ['J', 'Q', 'K'].include?(@rank)
  end

  def value_key
    {
      "A" => 1,
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
      "K" => 10
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

  def hand_value
    hand_total = 0
    @player_hand.each do |value|
      hand_total += value.card_value
    end
    return hand_total
  end

  def self.play
    blackjack=Hand.new
    puts "Welcome to Blackjack! Daddy needs a new pair of shoes!"
    puts "Player was delt:"
    blackjack.player_hand.each do |attribute|
      puts "#{attribute.rank} #{attribute.suit}"
    end
  #   unless blackjack.hand_value == 21
      # puts "Player score: #{blackjack.hand_value} "
      # print "Hit or stand (H/S):"
      # player_choice=gets.chomp.downcase
  #
  #     if player_choice == "h"
  #       blackjack.player_hand << blackjack.game_deck.draw!
  #       puts "Player hits."
  #       puts "Player was delt:"
  #       blackjack.player_hand.each{|attribute| p "#{attribute.rank} #{attribute.suit}" }
  #       puts "Player score: #{blackjack.hand_value} "
  #       puts "Hit or stand (H/S):"
  #       player_choice=gets.chomp.downcase
  #     elsif player_choice == "s"
  #       puts "Player stands."
  #     else
  #       puts "Please enter a valid choice"
  #     end
  #   else
  #     puts "Bust! YOU LOOOOOSE!!!!"
  #   end
    until blackjack.hand_value >= 21
      puts "Player score: #{blackjack.hand_value} "
      print "Hit or stand (H/S):"
      player_choice=gets.chomp.downcase
      case player_choice
        when "h"
          blackjack.player_hand << blackjack.game_deck.draw!
          puts "Player was delt:"
          blackjack.player_hand.each{|attribute| p "#{attribute.rank} #{attribute.suit}" }


        when "s"
          puts "Player score: #{blackjack.hand_value}"
          puts "Player stands."

        when blackjack.hand_value > 21
          puts "BUST!"

        when blackjack.hand_value = 21
          puts "YOU WIN! KACHING!"
      end
    end

  end

end

Hand.play

# deck = Deck.new
# card = Deck.draw!
# game_deck = Deck.new
# player_hand = Hand.new(card1, card2, [], game_deck)
# dealer_hand = Hand.new(card1, card2, [], game_deck)
