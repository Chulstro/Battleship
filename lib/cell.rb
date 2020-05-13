require '../lib/ship'
require 'pry'

class Cell

  attr_reader :coordinate

  def initialize(coordinate)
    @coordinate = coordinate
  end

  def place_ship(ship)
    @ship = ship
    true
  end

  def empty?
    if self.place_ship(@ship) == true
      false
    else
      true
    end
  end

  def ship
    if self.place_ship(@ship) == true
      @ship
    else
      "Cell is empty"
    end
  end

end
