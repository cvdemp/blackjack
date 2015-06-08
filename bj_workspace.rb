
until blackjack.hand_value == 21
  case player_choice
    when "h"
      blackjack.player_hand << blackjack.game_deck.draw!
      puts "Player was delt:"
      blackjack.player_hand.each{|attribute| p "#{attribute.rank} #{attribute.suit}" }
      puts "Player score: #{blackjack.hand_value}"

    when "s"
      puts "Player score: #{blackjack.hand_value}"
      puts "Player stands."

    when blackjack.hand_value > 21
      puts "BUST!"

    when blackjack.hand_value = 21
      puts "YOU WIN! KACHING!"
  end
end
