require 'byebug'
# Represents a computer Crazy Eights player.
class AIPlayer
  attr_reader :cards

  # Creates a new player and deals them a hand of eight cards.
  def self.deal_player_in(deck)
    AIPlayer.new(deck.take(8))
  end

  def initialize(cards)
    @cards = cards
  end

  # Returns the suit the player has the most of; this is the suit to
  # switch to if player gains control via eight.
  def favorite_suit
    suit_quantities = {}
    @cards.each do |card|

      unless suit_quantities[card.suit].nil?
        suit_quantities[card.suit] += 1
      else
        suit_quantities[card.suit] = 1
      end
    end
    # debugger
    max_val = suit_quantities.values.max
    suit_quantities.select {|k,v| v == max_val }.keys.first
  end

  # Plays a card from hand to the pile, removing it from the hand. Use
  # the pile's `#play` and `#play_eight` methods.
  def play_card(pile, card)
    raise "cannot play card outside your hand" unless @cards.include?(card)
    if card.value != :eight
      pile.play(card)
    elsif not card.nil?
      pile.play_eight(card, self.favorite_suit)
    else
      card = nil
      until pile.valid_play?(card)
        draw_from(deck)
        card = @cards.last
      end
      pile.play(card)
    end
    @cards.delete(card)

  end

  # Draw a card from the deck into player's hand.
  def draw_from(deck)
    @cards += deck.take(1)
  end

  # Choose any valid card from the player's hand to play; prefer
  # non-eights to eights (save those!). Return nil if no possible
  # play. Use `Pile#valid_play?` here; do not repeat the Crazy Eight
  # rules written in the `Pile`.
  def choose_card(pile)
    maybe_play = []
    card = nil
    @cards.each do |card|
      maybe_play << card if pile.valid_play?(card)
    end

    eight_cards = maybe_play.select {|card| card.value == :eight}
    non_eight_cards = maybe_play.select {|card| card.value != :eight}

    if non_eight_cards.length > 0
      card = non_eight_cards.pop
      return card
    elsif eight_cards.length > 0
      card = eight_cards.pop
      return card
    else
      card = nil
      return card
    end


  end

  # Try to choose a card; if AI has a valid play, play the card. Else,
  # draw from the deck and try again until there is a valid play.
  # If deck is empty, pass.
  def play_turn(pile, deck)
    card = self.choose_card(pile)
    if card.nil?
      self.draw_from(deck)
      card = @cards.last
      # debugger
      until pile.valid_play?(card)
        self.draw_from(deck)
        card = @cards.last
      end
    end
    play_card(pile, *card)
    # card = play_card(pile)
    # if card.value != :eight
    #   pile.play(card)
    # else
    #   pile.play_eight(card, self.favorite_suit)
    # end
    #

  end
end
