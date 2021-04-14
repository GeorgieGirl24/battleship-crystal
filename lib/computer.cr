class Computer
  getter board : Board
  getter cruiser : Ship
  getter submarine : Ship
  getter ship_count : Int32

  def initialize
    @board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
    @ship_count = 2
  end
end
