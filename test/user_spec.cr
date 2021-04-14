require "spec"
require "../lib/ship"
require "../lib/cell"
require "../lib/board"
require "../lib/computer"
require "../lib/user"

describe User do
  describe "attributes" do
    it "exsists" do
      user = User.new

      user.class.should eq User
    end

    it "can have attributes" do
      user = User.new
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)

      user.ship_count.should eq 2
      user.ship_count.should_not eq 3
      user.ship_count.should_not eq 1
    end
  end

  describe "place ships on the board" do
    it "can place a cruiser on the board" do
      user = User.new
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)
      cruiser_coordinates = ["D2", "D3", "D4"]
      submarine_coordinates = ["B2", "C2"]
      coordinates = "D2, D3, D4"

      board.valid_placement?(cruiser, cruiser_coordinates).should eq true
      board.valid_placement?(cruiser, cruiser_coordinates).should_not eq false

      board.place(cruiser, cruiser_coordinates).should eq [cruiser, cruiser, cruiser]
      board.place(cruiser, cruiser_coordinates).should_not eq [cruiser, cruiser, cruiser, cruiser]
      board.place(cruiser, cruiser_coordinates).should_not eq [cruiser, cruiser]
      board.place(cruiser, cruiser_coordinates).should_not eq [submarine, submarine, submarine]
    end

    it "can place a submarine on the board" do
      user = User.new
      board = Board.new
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
    end

  end

  describe "render the board" do
    it "can render a board with a cruiser on it" do
      user = User.new
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      cruiser_coordinates = ["B4", "C4", "D4"]

      board.place(cruiser, cruiser_coordinates)

      cruiser_board_visible = " 1 2 3 4 \nA . . . . \nB . . . S \nC . . . S \nD . . . S \n"
      cruiser_board = " 1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n"

      board.render(true).should eq cruiser_board_visible
      board.render(true).should_not eq cruiser_board
    end

    it "can render a board with a submarine on it" do
      user = User.new
      board = Board.new
      submarine = Ship.new("Submarine", 2)
      submarine_coordinates = ["C4", "D4"]

      board.place(submarine, submarine_coordinates)

      submarine_board = " 1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n"
      submarine_board_visible = " 1 2 3 4 \nA . . . . \nB . . . . \nC . . . S \nD . . . S \n"

      board.render(true).should eq submarine_board_visible
      board.render(true).should_not eq submarine_board
    end
  end
end
