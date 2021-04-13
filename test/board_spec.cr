require "spec"
require "../lib/ship"
require "../lib/cell"
require "../lib/board"

describe Board do
  describe "has attributes" do
    it "exsists" do
      board = Board.new
      board.class.should eq Board
    end

    it "has a hash" do
      board = Board.new
      board.@cells.class.should eq Hash(String, Cell)
    end

    it "has 16 cells in a default board" do
      board = Board.new
      board.@cells.size.should eq 16
      board.@cells.size.should_not eq 24
      board.@cells.size.should_not eq 8
    end

    it "has a coordinate as the key, cell object as the value" do
      board = Board.new
      board.@cells.keys[1].class.should eq String
      board.@cells.keys[1].class.should_not eq Cell

      board.@cells.values[1].class.should eq Cell
      board.@cells.values[1].class.should_not eq String
    end

    it "has all unique cells" do
      board = Board.new
      board.@cells.values.uniq.size.should eq 16
      board.@cells.values.uniq.size.should_not eq 12
      board.@cells.values.uniq.size.should_not eq 18
      board.@cells.keys.uniq.size.should eq 16
      board.@cells.keys.uniq.size.should_not eq 12
      board.@cells.keys.uniq.size.should_not eq 18
    end
  end

  describe "it the ability for valid coordinates" do
    it "can have a valid coordinate" do
      board = Board.new
      board.valid_coordinate?("A1").should eq true
      board.valid_coordinate?("A1").should_not eq false
    end

    it "can detect that a coordinate is outside the board" do
      board = Board.new

      board.valid_coordinate?("Q1").should eq false
      board.valid_coordinate?("P10").should eq false
      board.valid_coordinate?("D4").should_not eq false
      board.valid_coordinate?("C3").should_not eq false
    end
  end

  describe "it can have valid placement of ships on the board" do
    it "can not be valid placement if the lengths are not equal" do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)

      board.valid_placement?(cruiser, ["A1", "A2"]).should eq false
      board.valid_placement?(cruiser, ["A1", "A2"]).should_not eq true
      board.valid_placement?(submarine, ["A1", "A2", "A3"]).should eq false
      board.valid_placement?(submarine, ["A1", "A2", "A3"]).should_not eq true
    end

    it "can be valid placement if the lengths are equal" do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)

      board.valid_placement?(submarine, ["A1", "A2"]).should eq true
      board.valid_placement?(submarine, ["A1", "A2"]).should_not eq false
      board.valid_placement?(cruiser, ["A1", "A2", "A3"]).should eq true
      board.valid_placement?(cruiser, ["A1", "A2", "A3"]).should_not eq false
    end

    it "can be valid if the the coordinates are in consecutive order" do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)

      board.valid_placement?(submarine, ["A1", "A2"]).should eq true
      board.valid_placement?(submarine, ["D3", "D2"]).should eq false
      board.valid_placement?(submarine, ["D3", "D2"]).should_not eq true
      board.valid_placement?(cruiser, ["C1", "C2", "C3"]).should eq true
      board.valid_placement?(cruiser, ["C3", "C2", "C1"]).should eq false
      board.valid_placement?(cruiser, ["C3", "C2", "C1"]).should_not eq true
    end
    #
    it "can not be valid if the coordinates are not in consecutive order" do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)

      board.valid_placement?(submarine, ["C3", "D3"]).should eq true
      board.valid_placement?(submarine, ["B1", "A1"]).should eq false
      board.valid_placement?(submarine, ["D2", "C2"]).should eq false
      board.valid_placement?(submarine, ["D2", "C2"]).should_not eq true
      board.valid_placement?(cruiser, ["C1", "C2", "C3"]).should eq true
      board.valid_placement?(cruiser, ["D3", "C3", "B3"]).should eq false
      board.valid_placement?(cruiser, ["D3", "C3", "B3"]).should_not eq true
    end
  end
end
