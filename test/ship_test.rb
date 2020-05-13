require 'minitest'
require 'minitest/autorun'
require '../lib/ship'

class ShipTest < Minitest::Test
  def setup
    @cruiser = Ship.new("Cruiser", 3)
  end

  def test_it_exists
    assert_equal "Cruiser", @cruiser.name
    assert_equal 3, @cruiser.length
  end

  def test_its_health
    assert_equal 3, @cruiser.health

    @cruiser.hit
    assert_equal 2, @cruiser.health
  end

  def test_if_its_afloat
    assert_equal false, @cruiser.sunk?

    @cruiser.hit
    assert_equal false, @cruiser.sunk?

    @cruiser.hit
    assert_equal false, @cruiser.sunk?

    @cruiser.hit
    assert_equal true, @cruiser.sunk?
  end

  def test_health_removal
    @cruiser.hit

    assert_equal 2, @cruiser.health
  end
end
