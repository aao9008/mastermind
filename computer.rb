# This class holds methods for the computer player
class Computer
  def initialize(game)
    @game = game
    @guess = []
    @secret_code = []
    @guess_pool = []
  end
  attr_accessor :guess, :secret_code, :guess_pool

  def generate_code
    4.times do 
      @secret_code.push(@game.KEYS[rand(6)])
    end

    @secret_code
  end

  # Computer will pick random guess from availble guesses in guess pool 
  def pick_random_guess
    guess = guess_pool[rand(guess_pool.length)]
  end 

  def clear_guess
    @guess = []
  end

  # Generate pool of all possible codes. There are total of 1296 possiblites
  def generate_all_possible_codes(current_sequence = "0000")
    # Convert all numbers from 0000-5555 to color code equivalent
    return if current_sequence == "5556"

    # If sequence contains values outside of KEYS index range, increment sequence and move on to the next iteration
    if current_sequence.match?(/[6-9]/)
      # Increment sequence while maintinaing the XXXX number format
      current_sequence = "%04d" % (current_sequence.to_i + 1)
      generate_all_possible_codes(current_sequence)
    # If all numbers in sequence are value index values in KEYS array, proceed to process sequence
    else
      # Convert number sequence to color code
      convert_sequence_to_code(current_sequence)

      # Add color code to the guess pool
      guess_pool.push(guess)

      # Clear guess array for next sequence
      clear_guess

      # Increment sequence while maintinaing the XXXX number format
      current_sequence = "%04d" % (current_sequence.to_i + 1)

      # Move on to the next sequence
      generate_all_possible_codes(current_sequence)
    end 
  end

  # Remove any codes from the guess pool that do not result int he same result as the compouters inital guess 
  def update_guess_pool(partials, matches, code)
    # Check each guess in our guess pool against the computers guess
    guess_pool.each_with_index do |guess, index|
      # Get the matches and partials results of the computers guess
      guess_match = @game.full_match(guess, code)
      guess_partial = @game.partial_match(guess, code, guess_match)

      # If the match/partial result does not match that of the results of the computers guess
      if guess_match != matches || guess_partial != partials
        guess_pool.delete_at(index)
      end
    end
  end

  # Convert number sequence to color code
  def convert_sequence_to_code(sequence)
    sequence.each_char do |value|
      # For each number value in the sequence, get the corresponding color value from the KEYS array
      guess.push(@game.KEYS[value.to_i])
    end
  end

end
