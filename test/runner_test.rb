require 'minitest/autorun'
require './lib/runner'
require 'pry'

class RunnerTest < Minitest::Test

  def setup
    @runner = Runner.new("Chan", "Computer")
  end

  def test_it_exists
    assert_instance_of Runner, @runner
  end

  def test_it_places_ships
    @runner.place_ships_predetermined
    assert_equal "  1 2 3 4 \nA . S S S \nB . . . . \nC . S . . \nD . S . .", @runner.board.render(true)
  end

  def test
  end
end
