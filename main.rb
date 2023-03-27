require_relative 'human'
require_relative 'computer'
require_relative 'game'

Game.new(Human, Computer).guess_or_create
