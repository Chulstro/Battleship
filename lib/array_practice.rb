
##STEP 1: CREATE A BOARD
board = [["A1"],["A2"],["A3"],["B1"],["B2"],["B3"],["C1"],["C2"],["C3"]]
puts "Board: \n#{board}"
## STEP 2: BREAK COORDINATES INTO SUBARRAYS
chars_board = board.map do |coordinate|
  coordinate[0].chars
end


##STEP 3: CONVERT CHARACTERS TO NUMBERS
ord_board = chars_board.map do |x|
  [x[0].ord, x[1]]
end

puts "Board with letters converted to numbers: \n#{ord_board}"

##STEP 4: ISOLATE ONE COMPONENT OF COORDINATE INTO SUBARRAY
@arr = ord_board.select do |x|
  x[0] == 65
end

puts "Isolate subarray of one coordinate component: \n#{@arr}"

def valid_placement
  placement = @arr.sample(2)
  puts "Random Placement: #{placement}"
  if placement.max[1].to_i - placement.min[1].to_i + 1 == placement.count
    p "Placement is valid!"
  else
    p "Placement is not valid :("
  end
end


valid_placement
