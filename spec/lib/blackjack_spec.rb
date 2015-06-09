require 'rspec'
require 'pry'
require_relative "../../lib/blackjack"

describe "PlayingCard" do
  let(:playing_card) { PlayingCard.new("A", "hearts")}

  describe "#face_card?" do
    it "returns true if card is a face card" do
      expect(playing_card.face_card?).to eq(false)
    end
  end

  describe "#rank" do
    it "returns integer value of card" do
      expect(playing_card.rank).to eq(1)
    end
  end
end

describe "Deck" do
  let(:deck) { Deck.new }

  describe "#draw!" do
    it "returns a single card from the deck" do
      expect(deck.draw!).to be_a(PlayingCard)
    end
  end
end

describe "Hand" do
  let!(:deck) { Deck.new }
  let!(:hand) { Hand.new(deck) }
  describe "#value" do
    it "returns the value of the hand" do
      expect(hand.value).to eq(hand.card_one.rank + hand.card_two.rank)
    end
  end

end

describe "Game" do
  let!(:game_deck) { Deck.new }
  let!(:player_hand) { Hand.new(game_deck) }
  let(:game) { Game.new }
  describe "#player_hand" do
    it "returns two playingcard objects" do
      expect(game.player_hand).to be_a(PlayingCard)
    end
  end

  describe "#play" do
    it ""
  end

end
