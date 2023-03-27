# frozen_string_literal: true

# Class for human players
class Human
  def initialize(game)
    @game = game
    @guess = []
    @secret_code = []
  end
  attr_accessor :guess, :secret_code

  def player_guess
    puts 'Enter your code guess, color by color by pressing enter between each one.'
    puts 'Choose from the following: Red, orange, yellow, green, blue and pink'

    i = 1
    until @guess.length == 4
      print "Selection #{i}: "
      selection = gets.chomp.downcase

      if @game.valid_selection?(selection)
        @guess.push(selection)
        i += 1
      else
        puts 'Invalid selection. Please try again!'
      end
    end

    puts "\n", "Your guess is #{@guess}"
    return @guess
  end

  def player_secret_code
    puts 'Enter your secret code, color by color by pressing enter between each one.'
    puts 'Choose from the following: Red, orange, yellow, green, blue and pink'

    i = 1
    until @secret_code.length == 4
      print "Selection #{i}: "
      selection = gets.chomp.downcase

      if @game.valid_selection?(selection)
        @secret_code.push(selection)
        i += 1
      else
        puts 'Invalid selection. Please try again!'
      end
    end

    puts "Your secret code is #{@secret_code}","\n"
    return @secret_code
  end

  def clear_guess
    @guess = []
  end
end
