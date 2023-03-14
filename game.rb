module mastermind
    # Array of all code selections
    KEYS = ["red", "orange", "yellow", "green", "blue", "pink"]
    # This class will handle all of the game functions/logic
    class Game
        def initialize (player, cpu)
            
            
    
        end

        def intro_text
            puts <<-Intro

            Welcome to Mastermind!

            Mastermind is a code-breaking game for two players.

            In this version it's you against the computer - you get to choose whether to be
            code-breaker or code-maker.

            The code-breaker gets 12 attempts to guess the code set by the code-maker.

            Good luck!! You'll need it... The computer is good!

            Intro
        end
    end 

end