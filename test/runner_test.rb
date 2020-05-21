require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/runner'
require 'pry'

class RunnerTest < Minitest::Test

  def setup
    @runner = Runner.new("Chan", "Computer")
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
    @board = Board.new
  end

  def test_it_exists
    assert_instance_of Runner, @runner
  end

end
