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
    if @ship == nil
      true
    else
      false
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
    if self.empty? == true
      @damage = true
      true
    elsif self.empty? == false && self.fired_upon? == true
    else
      @damage = true
      @ship.hit
    end
  end

  def show_miss
    if self.fired_upon? == false
      "."
    elsif self.fired_upon? == true
      "M"
    end
  end

  def hide_ships
    if self.empty? == true
      show_miss
    elsif self.empty? == false
      if self.fired_upon? == false
        "."
      elsif self.ship.sunk? == true
        "X"
      elsif self.fired_upon? == true
        "H"
      end
    end
  end

  def show_ships
    if self.empty? == true
      show_miss
    elsif self.empty? == false
      if self.fired_upon? == false
        "S"
      elsif self.ship.sunk? == true
        "X"
      elsif self.fired_upon? == true
        "H"
      end
    end

  end

  def render(boolean = false)
    if boolean == false
      hide_ships
    else
      show_ships
    end
  end

end
