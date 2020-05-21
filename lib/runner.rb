require './lib/ship'
require './lib/cell'
require './lib/board'
require 'pry'

class Runner
  attr_reader :board, :shot

  def initialize(player_1, player_2 = "Computer")
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
    @cruiser_array = []
    @sub_array = []
    @sub_location = []
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

    puts "Enter the THREE coordinates for your cruiser placement"
    puts "Coordinates must be entered sequentially (A1 -> A2 -> A3, or B2 -> C2 -> D2)"
    print "Coordinate 1: "
    @coord1 = gets.chomp
    print "Coordinate 2: "
    @coord2 = gets.chomp
    print "Coordinate 3: "
    @coord3 = gets.chomp
    @cruiser_array = [@coord1, @coord2, @coord3]

    @cruiser_array.select do |coord|
      if @board2.valid_coordinate?(coord) == false
        puts "=" *25
        puts "Coordinates are not valid!!! Please retry ship placement."
        puts "=" *25
        place_cruiser
      end
    end

    if @board2.valid_placement?(@cruiser2, @cruiser_array) == true
      puts "Cruiser is in position!"
      puts ""
    else
      puts "Cruiser position is not valid, please try again."
    end
  end

  def place_submarine

    puts "Your submarine occupies two adjacent cells."
    puts "Enter the TWO sequential coordinates for your submarine: "
    print "Coordinate 1: "
    @coord_sub_1 = gets.chomp
    print "Coordinate 2: "
    @coord_sub_2 = gets.chomp
    @sub_array = [@coord_sub_1, @coord_sub_2]

    @sub_array.select do |coord|
      if @board2.valid_coordinate?(coord) == false
        puts "=" *25
        puts "Coordinates are not valid!!! Please retry ship placement."
        puts "=" *25
        place_submarine
      end
    end

    if @board2.valid_placement?(@submarine2, @sub_array) == true
      puts "Ships are placed. Get ready to play!"
    else
      puts "Submarine position is not valid, please try again."
    end
  end

  def intro
    puts "WELCOME TO BATTLESHIP!!"
    puts ""
    puts "Let's place your ships."
    puts "You have two ships, a cruiser and a submarine."

    puts "Your cruiser occupies 3 adjacent cells, and cannot be placed diagonally."
    puts ""
    @board_cruiser_ex_1 = Board.new
    @board_cruiser_ex_2 = Board.new
    @board_cruiser_ex_1.cells
    @board_cruiser_ex_2.cells
    cruiser_ex = Ship.new("Cruiser",3)
    @board_cruiser_ex_1.place(cruiser_ex, ["B2","B3","B4"])
    puts "For example, here are two valid placements for your cruiser"
    puts "=" *25
    puts "First Placement: Coordinates B2, B3, and B4: "
    print @board_cruiser_ex_1.render(true)
    puts "=" *25
    puts "Second Placement: Coordinates A2, B2, and C2: "
    @board_cruiser_ex_2.place(cruiser_ex, ["A2","B2","C2"])
    print @board_cruiser_ex_2.render(true)
    puts "="*25
  end

  def place_both_ships

    intro
    until (@board2.valid_placement?(@cruiser2, @cruiser_array) )
      place_cruiser
    end

    @board2.place(@cruiser2, @cruiser_array)
    print @board2.render(true)
    puts ""

    until (@board2.valid_placement?(@submarine2, @sub_array))
      place_submarine
    end

    @board2.place(@submarine2, @sub_array)
    print @board2.render(true)
  end

  def start
    place_both_ships
    place_ships
    puts "I have placed my defenses!"
    computer_shot_order
    until ( (@cruiser.sunk? && @submarine.sunk?) ||(@cruiser2.sunk? && @submarine2.sunk?)) do
      get_player_shot_input

      board.cells[shot].fire_upon
      @board2.cells[@random_selection[0]].fire_upon
      @random_selection.shift

      puts "Enemy Board:"
      print @board.render
      puts ""
      puts "Your Board:"
      print @board2.render(true)
      puts ""
    end
    puts "Thanks for playing!"
  end

  def place_ships
    cruiser_locations = [
      ["A1", "A2", "A3"], ["A2", "A3", "A4"], ["B1", "B2", "B3"], ["B2", "B3", "B4"],
      ["C1", "C2", "C3"], ["C2", "C3", "C4"], ["D1", "D2", "D3"], ["D2", "D3", "D4"],
      ["A1", "B1", "C1"], ["B1", "C1", "D1"], ["A2", "B2", "C2"], ["B2", "C2", "D2"],
      ["A3", "B3", "C3"], ["B3", "C3", "D3"], ["A4", "B4", "C4"], ["B4", "C4", "D4"]
    ]
    board.place(@cruiser, cruiser_locations.sample)

    submarine_locations = [
      ["A1", "A2"], ["A2", "A3"], ["A3", "A4"],
      ["B1", "B2"], ["B2", "B3"], ["B3", "B4"],
      ["C1", "C2"], ["C2", "C3"], ["C3", "C4"],
      ["D1", "D2"], ["D2", "D3"], ["D3", "D4"],
      ["A1", "B1"], ["B1", "C1"], ["C1", "D1"],
      ["A2", "B2"], ["B2", "C2"], ["C2", "D2"],
      ["A3", "B3"], ["B3", "C3"], ["C3", "D3"],
      ["A4", "B4"], ["B4", "C4"], ["C4", "D4"]
    ]

    until board.valid_placement?(@submarine, @sub_location)
      @sub_location = submarine_locations.sample
    end
    board.place(@submarine, @sub_location)
  end

  def computer_shot_order
    @random_selection = @board2.cells.keys.shuffle
  end
end

run = Runner.new("Chan", "Comp")
run.start
