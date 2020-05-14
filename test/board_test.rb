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
  end

end
