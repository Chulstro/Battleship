require './lib/ship'
require './lib/cell'
require './lib/board'
require 'pry'


class Runner
  attr_reader :player_1,
              :player_2,
              :cruiser,
              :submarine,
              :board

  def initialize(player_1, player_2)
    @player_1 = player_1
    @player_2 = player_2
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
    @board = Board.new
    @board.cells
  end

  def start
    initial_statement
    place_ships_predetermined
    # shot = gets.chomp
    # @board.cells[shot].fire_upon
    # @board.render
  end

  def place_ships_predetermined
    @board.place(@cruiser, ["A2", "A3", "A4"])
    @board.place(@submarine, ["C2", "D2"])
  end

  def place_ships
    @board.place(@cruiser, RANDOM)
    @board.place(@submarine, RANDOM)
  end

  def random_cells(number)
    cell_keys = @board.cells.keys
    direction = (1..2).sample
    cell_keys.sample
    if coordinates == @board.valid_placement?
  end

  def initial_statement
    puts "Welcome to BATTLESHIP"
    puts "Enter p to play. Enter q to quit."
  end
end
