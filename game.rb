module MasterMind
  # Array of all code selections
  KEYS = %w[red orange yellow green blue pink].freeze
  # This class will handle all of the game functions/logic
  class Game
    def initialize(player, cpu)
      @human = player.new(self)
      @cpu = cpu.new(self)

      intro_text
    end

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
      KEYS.include?(selection.downcase)
    end

    def test
      @human.player_guess
    end
  end
end
