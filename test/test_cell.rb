require 'minitest/autorun'
require 'minitest/pride'
require '../lib/cell'
require 'pry'

class CellTest < Minitest::Test

  def setup
    @cell = Cell.new('B4')
    @cruiser = Ship.new("Cruiser",3)
  end

  def test_it_exists
    @cell

    assert_instance_of Cell, @cell
    assert_equal 'B4', @cell.coordinate
  end

  def test_it_can_place_ship
    assert_equal true, @cell.place_ship(@cruiser)
  end

  def test_it_can_determine_if_empty
    @cell.place_ship(@cruiser)

    assert_equal false, @cell.empty?
  end

  def test_it_can_determine_which_ship_occupies_it
    @cell.place_ship(@cruiser)
    assert_equal @cruiser, @cell.ship
  end


end
