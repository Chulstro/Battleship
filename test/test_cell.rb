require 'minitest/autorun'
require 'minitest/pride'
require '../lib/cell'
require '../lib/ship'
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
    assert_equal true, @cell.empty?
    @cell.place_ship(@cruiser)

    assert_equal false, @cell.empty?
  end

  def test_it_can_determine_which_ship_occupies_it
    assert_nil @cell.ship
    @cell.place_ship(@cruiser)
    assert_equal @cruiser, @cell.ship
  end

  def test_it_has_been_fired_upon
    @cell.place_ship(@cruiser)
    assert_equal false, @cell.fired_upon?

    @cell.fire_upon
    assert_equal true, @cell.fired_upon?

    cell2 = Cell.new("C3")
    cell2.fire_upon
    assert_equal true, @cell.fired_upon?
  end

  def test_it_can_determine_health
    @cell.place_ship(@cruiser)
    assert_equal 3, @cell.ship.health

    @cell.fire_upon
    assert_equal 2, @cell.ship.health
    @cell.fire_upon
    assert_equal 2, @cell.ship.health
  end

  def test_empty_rendering

    assert_equal ".", @cell.render

    @cell.fire_upon
    assert_equal "M", @cell.render
  end

  def test_it_can_render_ship
    @cell.place_ship(@cruiser)
    assert_equal ".", @cell.render
    assert_equal "S", @cell.render(true)
    @cell.fire_upon
    assert_equal "H", @cell.render
  end

  def test_it_can_render_sunken_ship
    @cell.place_ship(@cruiser)
    @cell.fire_upon
    @cell.ship.hit
    @cell.ship.hit
    assert_equal "X", @cell.render(true)
  end

end
