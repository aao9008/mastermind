require_relative 'human'
require_relative 'computer'
require_relative 'game'

include MasterMind

Game.new(Human, Computer).test
