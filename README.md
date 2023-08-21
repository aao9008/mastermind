# Mastermind

## Rules
[Source](cardgamedatabase.fandom.com)

The codebreaker tries to guess the pattern, in both order and color, within twelve (or ten, or eight) turns. Each guess is made by placing a row of code pegs on the decoding board. Once placed, the codemaker provides feedback by placing from zero to four key pegs in the small holes of the row with the guess. A colored or black key peg is placed for each code peg from the guess which is correct in both color and position. A white key peg indicates the existence of a correct color code peg placed in the wrong position.[4]

If there are duplicate colours in the guess, they cannot all be awarded a key peg unless they correspond to the same number of duplicate colours in the hidden code. For example, if the hidden code is white-white-black-black and the player guesses white-white-white-black, the codemaker will award two colored key pegs for the two correct whites, nothing for the third white as there is not a third white in the code, and a colored key peg for the black. No indication is given of the fact that the code also includes a second black.[5]

Once feedback is provided, another guess is made; guesses and feedback continue to alternate until either the codebreaker guesses correctly, or twelve (or ten, or eight) incorrect guesses are made. 

## Program Features
Player begin by choosing to be Codebreaker or Codemaker at the start
### Codebreaker
1. Codebreaker will have to input their guess from the 6 colors provided
2. The computer will generate respective feedback according to their guess
3. Player wins if the correct code is guessed within 12 rounds

### Codemaker
1. Codemaker will create a code from the 6 colors provided
2. The computer will guess according to the respective feedback provided each round
    - If a color they guessed is not in the right position, the computer will randomly guess a different colour on the next round
    - If a color they guessed is in the right position, the computer will retain its choice on the next round
3. Player wins if the correct code is not guessed within 12 rounds
