require 'minitest/autorun'
require '../lib/board'
require '../lib/ship'
require '../lib/cell'
require 'pry'

class BoardTest < Minitest::Test

  def setup
    @board = Board.new
  end

  def test_cells_array
    assert_equal "A1", @board.cell_list[0].coordinate
    assert_equal "C2", @board.cell_list[9].coordinate
  end

  def test_cells_hash_exists
    assert_equal true, @board.cells.has_key?("A2")
    assert_equal true, @board.cells.has_key?(@board.cells.keys.sample)
    assert_equal [@board.cell_list[0]], @board.cells.values_at("A1")
  end

  def test_coordinate_it_valid
    @board.cells
    assert_equal true, @board.valid_coordinate?("A1")
    assert_equal false, @board.valid_coordinate?("E2")
  end

  def test_valid_ship_placements
    @board.cells

    cruiser = Ship.new("Cruiser",3)
    submarine = Ship.new("Submarine",2)

    assert_equal false, @board.valid_placement?(cruiser, ["A1", "A2"])
    assert_equal true,  @board.valid_placement?(cruiser, ["A1", "A2", "A3"])

    assert_equal false, @board.valid_placement?(cruiser, ["A1", "A2", "A4"])
    assert_equal false, @board.valid_placement?(submarine, ["A1", "C1"])
    assert_equal false, @board.valid_placement?(cruiser, ["A3", "A2", "A1"])
    assert_equal false, @board.valid_placement?(submarine, ["C1", "B1"])

    assert_equal false, @board.valid_placement?(cruiser, ["A1", "B2", "C3"])
    assert_equal false, @board.valid_placement?(submarine, ["C2", "D3"])
  end

  def test_place_ship_and_overlap
    @board.cells

    cruiser = Ship.new("Cruiser",3)
    submarine = Ship.new("Submarine",2)
    @board.place(cruiser, ["A1", "A2", "A3"])

    assert_equal false, @board.valid_placement?(submarine, ["A2", "B2"])
  end

  def test_cells_have_same_ship
    @board.cells

    cruiser = Ship.new("Cruiser",3)
    submarine = Ship.new("Submarine",2)
    @board.place(cruiser, ["A1", "A2", "A3"])
    cell_1 = @board.cells["A1"]
    cell_2 = @board.cells["A2"]

    assert_equal true, cell_1.ship == cell_2.ship
  end

  def test_board_matrix_rendering
    @board.cells

    cruiser = Ship.new("Cruiser",3)
    submarine = Ship.new("Submarine",2)
    @board.place(cruiser, ["A1", "A2", "A3"])
    @board.place(submarine, ["C1", "C2"])
    # binding.pry

    assert_equal "  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . .", @board.render
    @board.cells["A4"].fire_upon
    @board.cells["C1"].fire_upon
    @board.cells["C2"].fire_upon
    @board.cells["A2"].fire_upon
    assert_equal "  1 2 3 4 \nA . H . M \nB . . . . \nC X X . . \nD . . . .", @board.render
    assert_equal "  1 2 3 4 \nA S H S M \nB . . . . \nC X X . . \nD . . . .", @board.render(true)
  end
end
