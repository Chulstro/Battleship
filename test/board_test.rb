require 'minitest/autorun'
require './lib/board'
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

end
