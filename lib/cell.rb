
require './lib/ship'
require 'pry'

class Cell

  attr_reader :coordinate,
              :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @damage = false
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
    end
  end

  def fired_upon?
    if @damage == true
      true
    else
      false
    end
  end

  def fire_upon
    if self.fired_upon? == false
    @damage = true
    @ship.hit
    end
  end

  def render(boolean = false)
    if self.fired_upon? == false
      "."
    elsif self.fired_upon? == true
      "M"


    end
  end
end
