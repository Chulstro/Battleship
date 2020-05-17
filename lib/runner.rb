require '../lib/ship'
require '../lib/cell'
require '../lib/board'
require 'pry'


class Runner
  attr_reader :board, :shot

  def initialize(player_1, player_2)
    @player_1 = player_1
    @player_2 = player_2

    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
    @board = Board.new

    @board2 = Board.new
    @cruiser2 = Ship.new("Cruiser", 3)
    @submarine2 = Ship.new("Submarine",2)

    @board.cells
    @board2.cells
  end

  def get_player_shot_input
    puts "Fire when ready!"
    @shot = gets.chomp

    if board.valid_coordinate?(shot) == false
      puts "Please enter a valid coordinate..."
      get_player_shot_input
    end
  end

  def place_cruiser

    puts "Please place your cruiser!"
    puts "Your cruiser occupies 3 adjacent cells, and cannot be placed diagonally."

    @board_cruiser_ex_1 = Board.new
    @board_cruiser_ex_2 = Board.new
    @board_cruiser_ex_1.cells
    @board_cruiser_ex_2.cells
    cruiser_ex = Ship.new("Cruiser",3)
    # @board_cruiser_ex_1.place(cruiser_ex, ["B2","B3","B4"])
    # @board_cruiser_ex_2.place(cruiser_ex, ["A2","B2","C2"])
    puts "For example, here are two valid placements for your cruiser"
    puts "=" *25
    puts "First Placement: Coordinates B2, B3, and B4: "
    @board_cruiser_ex_1.render(true)
    puts "=" *25
    puts "Second Placement: Coordinates A2, B2, and C2: "
    @board_cruiser_ex_2.render(true)
    puts "="*25

    puts "Enter the three coordinates for your cruiser placement: "

    print "Coordinate 1: "
    @coord1 = gets.chomp
    print "Coordinate 2: "
    @coord2 = gets.chomp
    print "Coordinate 3: "
    @coord3 = gets.chomp

    @cruiser_array = [@coord1, @coord2, @coord3]
    p @board2.valid_placement?(@cruiser2, @cruiser_array)


    @board2.place(@cruiser2, @cruiser_array)

  end

  def start

    @board.cells
    place_ships
    puts "I have placed my defenses!"

    until ( (@cruiser.sunk? && @submarine.sunk?) ||(@cruiser2.sunk? && @submarine2.sunk?)) do
      get_player_shot_input

      board.cells[shot].fire_upon
      puts "Enemy Board:"
      board.render
      # p @cruiser.sunk?
      # p @submarine.sunk?
    end
    puts "Thanks for playing!"
  end

  def place_ships
    board.place(@cruiser, ["A2", "A3", "A4"])
    board.place(@submarine, ["C2", "D2"])
  end


end

game = Runner.new("player1","player2")
game.place_cruiser
