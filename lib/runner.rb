require './lib/ship'
require './lib/cell'
require './lib/board'
require 'pry'


class Runner
  attr_reader

  def initialize(player_1, player_2)
    @player_1 = player_1
    @player_2 = player_2
  end

  def start
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
    @board = Board.new
    @board.cells
    place_ships
    puts "I have placed my defenses!"
    puts "Fire when ready"
    shot = gets.chomp
    @board.cells[shot].fire_upon
    @board.render
  end

  def place_ships
    @board.place(@cruiser, ["A2", "A3", "A4"])
    @board.place(@submarine, ["C2", "D2"])
  end
end
