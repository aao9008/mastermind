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
      player_code_game
    end
  end

  # This function handles all logic for a game where the user is the code-breaker
  def player_guess_game
    # Computer will generate a secret code
    secret = cpu.generate_code

    puts "\n", "LETS GET READY TO RUMMMMMMBLE!", "\n"
    
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
    puts "Matches: #{matches}", "Partials: #{partials}","\n"

    # Decrement round count and clear guess
    round -= 1
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

  def player_code_guessed(guess, secret)
    if guess == secret
      puts "The T-1000 guessed the code! THE MACHINES HAVE WON"
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

  # This section contains functions for game where computer is the code breaker

  def player_code_game
    # User will select a secret code
    secret = human.player_secret_code

    #Computer generates all possible code combos
    cpu.generate_all_possible_codes

    # Computer plays 12 rounds of mastermind
    computer_guess_round(secret)
    
  end

  def computer_guess_round(secret, round = 12)
    return if game_over(round)

    puts "The T-1000 has #{round} guesses left"
    # Computer selects guess from guess pool
    guess = cpu.pick_random_guess

    puts "The T-1000 guessed #{guess}"

    return if human_code_guessed(guess, secret)

    # Calculate any matches or partials
    matches = full_match(guess, secret)
    partials = partial_match(guess, secret, matches)

    # Display matches and partials
    puts "Matches: #{matches}", "Partials: #{partials}","\n"

    puts "Thinking....", "\n"

    sleep(3) # Puase code execution 

    cpu.update_guess_pool(partials, matches, guess)

    # Decrement round count and clear guess
    round -= 1
    cpu.clear_guess
    # Play next round
    computer_guess_round(secret, round)
  end 

  def human_code_guessed(guess, secret)
    if guess == secret
      puts "The T-1000 guessed the code!","THE MACHINES HAVE WON!"
      return true
    end

    false
  end 

  def game_won(round)
    if round == 0
      puts "The T-100 has no guesses left! Humans have won!"
      return true
    end
    false
  end
end
