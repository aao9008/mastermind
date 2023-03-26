# This class will handle all of the game functions/logic
class Game
  def initialize(player, cpu)
    # Array of all code selections
    @KEYS = %w[red orange yellow green blue pink].freeze

    @human = player.new(self)
    @cpu = cpu.new(self)

    intro_text
  end
  attr_accessor :human, :cpu, :KEYS

  def intro_text
    puts <<-INTRO
      Welcome to Mastermind!

      Mastermind is a code-breaking game for two players.

      In this version it's you against the computer - you get to choose whether to be
      code-breaker or code-maker.

      The code-breaker gets 12 attempts to guess the code set by the code-maker.

      Good luck!! You'll need it... The computer is good!
    INTRO
  end

  # This function will check that user input is valid
  def valid_selection?(selection)
    @KEYS.include?(selection.downcase)
  end

  # Take the guess array from the guesser and the secret code array from the creator
  def full_match(guess, secret_code)
    # Compare each index of the secret code to the corresponding index of the guess.
    secret_code.select.with_index { |key, index| key == guess[index] }.length # Return count of key mathes
  end

  def partial_match(guess, secret_code, match_count, partial_count = 0)
    unique_keys = secret_code.uniq

    unique_keys.each do |key|
      unless guess.include?(key) then next end

      partial_count = if secret_code.count(key) > guess.count(key)
                        partial_count + guess.count(key)
                      else
                        partial_count + secret_code.count(key)
                      end
    end
    partial_count -= match_count
  end

  def guess_or_create
    puts "Would you like to create the code to be guessed by the computer or guess the computers code (please enter 'create' or 'guess')"
    answer = gets.chomp.downcase
    until answer.match?(/\bguess\b|\bcreate\b/)
      puts "Please choose whether you want to guess the code or create by typing 'guess' or 'create'\nTry again..."
      answer = gets.chomp.downcase
    end
    if answer == 'guess'
      player_guess_game
    else
      player_code_round
    end
  end

  # This function handles all logic for a game where the user is the code-breaker
  def player_guess_game
    # Computer will generate a secret code
    secret = %w[red blue green pink]

    # Play round of mastermind
    player_guess_round(secret)
  end

  def player_guess_round(secret, round = 12)
    return if game_over(round)

    puts "You have #{round} guesses left"
    # Get guess from the code breaker
    guess = human.player_guess

    # End game if player has broken the code
    return if cpu_code_guessed(guess, secret)

    # Calculate any matches or partials
    matches = full_match(guess, secret)
    partials = partial_match(guess, secret, matches)
    # Display matches and partials
    puts "Matches: #{matches}", "Partials: #{partials}"

    # Decrement round count and clear guess
    puts round -= 1
    human.clear_guess
    # Play next round
    player_guess_round(secret, round)
  end

  def cpu_code_guessed(guess, secret)
    if guess == secret
      puts "You guessed the code!"
      return true
    end

    false
  end

  def game_over(round)
    if round == 0
      puts "You have no guesses left! Game over!"
      return true
    end

    false
  end

  def test
    player_guess_game
  end
end
