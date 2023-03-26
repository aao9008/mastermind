# This class holds methods for the computer player
class Computer
  def initialize(game)
    @game = game
    @guess = []
    @secret_code = []
  end
  attr_accessor :guess, :secret_code

  def generate_code
    4.times do 
      @secret_code.push(@game.KEYS[rand(6)])
    end
  end
end
