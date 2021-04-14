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

  def place_submarine
    loop do
      submarine_coordinates = Array(String).new
      until submarine_coordinates.size == submarine.length
        submarine_coordinates << board.@cells.keys.sample
      end
      if board.valid_placement?(@submarine, submarine_coordinates)
        board.place(@submarine, submarine_coordinates)
        return submarine_coordinates
        break
      end
    end
  end

  def place_cruiser
    loop do
      cruiser_coordinates = Array(String).new
      until cruiser_coordinates.size == cruiser.length
        cruiser_coordinates << board.@cells.keys.sample
      end
      if board.valid_placement?(@cruiser, cruiser_coordinates)
        board.place(@cruiser, cruiser_coordinates)
        return cruiser_coordinates
        break
      end
    end
  end
end
