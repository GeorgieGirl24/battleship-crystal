class User
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

  def place_cruiser
    puts @board.render(true)
    puts "Enter the squares for the Cruiser (3 spaces): 🚢"
    print "> "
    loop do
      coordinates = gets.chomp.upcase.gsub(", ", " ").split
      if board.valid_placement?(cruiser, coordinates)
        board.place(cruiser, coordinates)
        puts "You did it! You're selection is valid!"
        break
      else
        puts "Invalid response. Please try again."
        print "> "
      end
    end
  end

  def place_submarine
    puts board.render(true)
    puts "Now enter the squares for the Submarine (2 spaces): ⛵️"
    print "> "
    loop do
      coordinates = gets.chomp.upcase.gsub(", ", " ").split
      if board.valid_placement?(submarine, coordinates)
        board.place(submarine, coordinates)
        puts "You did it! You're selection is valid!"
        break
      else
        puts "Invalid response. Please try again."
        print "> "
      end
    end
  end
end
