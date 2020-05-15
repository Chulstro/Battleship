require './lib/cell'
require 'pry'

class Board
  attr_reader :cell_list, :cells

  def initialize
    @cell_list = [
      a1 = Cell.new("A1"),
      a2 = Cell.new("A2"),
      a3 = Cell.new("A3"),
      a4 = Cell.new("A4"),
      b1 = Cell.new("B1"),
      b2 = Cell.new("B2"),
      b3 = Cell.new("B3"),
      b4 = Cell.new("B4"),
      c1 = Cell.new("C1"),
      c2 = Cell.new("C2"),
      c3 = Cell.new("C3"),
      c4 = Cell.new("C4"),
      d1 = Cell.new("D1"),
      d2 = Cell.new("D2"),
      d3 = Cell.new("D3"),
      d4 = Cell.new("D4")
    ]
  end

  def cells
    combo_cells = cell_list.map {|x| [x.coordinate, x]}
    @cells = combo_cells.to_h
    @cells
  end

  def valid_coordinate?(coordinate)
    @cells.has_key?(coordinate)
  end

  def valid_placement?(ship, coordinates)
    coord_letter = coordinates.map {|str| str.ord}
    coord_num = coordinates.map {|str| str[1].to_i}
    if ship.length == coordinates.count
      if coord_letter.uniq.count == 1
        coord_num == (coord_num.min..coord_num.max).to_a
      elsif coord_num.uniq.count == 1
        coord_letter == (coord_letter.min..coord_letter.max).to_a
      else
        false
      end
    else
      false
    end
  end
end
