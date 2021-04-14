require "spec"
require "../lib/ship"
require "../lib/cell"
require "../lib/board"
require "../lib/computer"

describe Computer do
  describe "has attributes" do
    it "exsists" do
      computer = Computer.new
      computer.class.should eq Computer
    end

    it "has four attributes" do
      computer = Computer.new
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)

      computer.ship_count.should eq 2
    end
  end

  describe "a ship can be placed on the board " do
    it "can place a cruiser"do
      board = Board.new
      computer = Computer.new
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)
      cruiser_coordinates = ["D2", "D3", "D4"]
      submarine_coordinates = ["B2", "C2"]

      board.valid_placement?(cruiser, cruiser_coordinates).should eq true
      board.valid_placement?(cruiser, cruiser_coordinates).should_not eq false

      board.place(cruiser, cruiser_coordinates).should eq [cruiser, cruiser, cruiser]
      board.place(cruiser, cruiser_coordinates).should_not eq [cruiser, cruiser, cruiser, cruiser]
      board.place(cruiser, cruiser_coordinates).should_not eq [cruiser, cruiser]
      board.place(cruiser, cruiser_coordinates).should_not eq [submarine, submarine, submarine]

      computer.place_cruiser.size.should eq 3
      computer.place_cruiser.size.should_not eq 2
      computer.place_cruiser.size.should_not eq 4
      computer.place_cruiser.class.should eq Array(String)
    end

    it "can place a submarine"do
    board = Board.new
    computer = Computer.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    cruiser_coordinates = ["D2", "D3", "D4"]
    submarine_coordinates = ["B2", "C2"]

    board.valid_placement?(submarine, submarine_coordinates).should eq true
    board.valid_placement?(submarine, submarine_coordinates).should_not eq false

    board.place(submarine, submarine_coordinates).should eq [submarine, submarine]
    board.place(submarine, submarine_coordinates).should_not eq [submarine, submarine, submarine, submarine]
    board.place(submarine, submarine_coordinates).should_not eq [submarine, submarine, submarine]
    board.place(submarine, submarine_coordinates).should_not eq [cruiser, cruiser]

    computer.place_submarine.size.should eq 2
    computer.place_submarine.size.should_not eq 3
    computer.place_submarine.size.should_not eq 1
    computer.place_submarine.class.should eq Array(String)
    end
  end
end
