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

    it "can see all the letters in coordinate are not the same" do
      board = Board.new

      board.all_letters_same?(["A1", "A2","B3"]).should eq false
      board.all_letters_same?(["A1", "A2","A3"]).should eq true
    end

    it "can see all the numbers in coordinate are not the same" do
      board = Board.new

      board.all_numbers_same?(["A1", "B2","C3"]).should eq false
      board.all_numbers_same?(["A1", "B1","C1"]).should eq true
    end

    it "can check that the numbers are consecutive" do
      board = Board.new

      board.consecutive_numbers?(["A1", "B2","C3"]).should eq true
      board.consecutive_numbers?(["A1", "A2","A3"]).should eq true
      board.consecutive_numbers?(["A3", "A2","A1"]).should eq false
      board.consecutive_numbers?(["A2", "A3","A1"]).should eq false
    end

    it "can check that the letters are consecutive" do
      board = Board.new

      board.consecutive_letters?(["A1", "B2","C3"]).should eq true
      board.consecutive_letters?(["A3", "B3","C3"]).should eq true
      board.consecutive_letters?(["C3", "B2","A1"]).should eq false
      board.consecutive_letters?(["B2", "C3","A1"]).should eq false
    end

    it "can check that the numbers are consecutive and all the letters are the same" do
      board = Board.new

      board.valid_numbers?(["A1", "B2","C3"]).should eq false
      board.valid_numbers?(["C3", "C2","C1"]).should eq false
      board.valid_numbers?(["C2", "C1","C3"]).should eq false
      board.valid_numbers?(["C1", "C2","C3"]).should eq true
      board.valid_numbers?(["A1", "A2","A3"]).should eq true
    end

    it "can check that the letters are consecutive and all the numbers are the same" do
      board = Board.new

      board.valid_letters?(["A1", "B2","C3"]).should eq false
      board.valid_letters?(["B3", "C3","A3"]).should eq false
      board.valid_letters?(["C1", "B1","A1"]).should eq false
      board.valid_letters?(["B1", "C1","D1"]).should eq true
      board.valid_letters?(["A4", "B4","C4"]).should eq true
    end

    it "can create an array of letters and convert them to ord numbers" do
      board = Board.new
      columns = ("A".."D").to_a

      board.make_letters_ord_numbers.should eq [65, 66, 67, 68]
      board.make_letters_ord_numbers.should_not eq [68, 67, 66, 65]
    end

    it "can find the letter of the coordinate and convert it to an ord number" do
      board = Board.new

      board.find_letters(["A1", "A2", "A3"]).should eq [65, 65, 65]
      board.find_letters(["C1", "B2", "D3"]).should eq [67, 66, 68]
      board.find_letters(["P1", "H2", "Z3"]).should eq [80, 72, 90]
      board.find_letters(["P11", "H15", "Z23"]).should eq [80, 72, 90]
      board.find_letters(["A1", "A2", "A3"]).should_not eq [1, 1, 1]
    end


    it "can find the number of the coordinate" do
      board = Board.new

      board.find_digits(["A1", "A2", "A3"]).should eq [1, 2, 3]
      board.find_digits(["C1", "B2", "D3"]).should eq [1, 2, 3]
      board.find_digits(["P8", "H10", "Z13"]).should eq [8, 10, 13]
      board.find_digits(["P11", "H15", "Z23"]).should eq [11, 15, 23]
      board.find_digits(["A1", "A2", "A3"]).should_not eq [65, 65, 65]
    end

    it "can find the letters of the coordinate" do
      board = Board.new

      board.find_letters(["A1", "A2", "A3"]).should eq [65, 65, 65]
      board.find_letters(["B1", "A2", "C3"]).should eq [66, 65, 67]
      board.find_letters(["K1", "G2", "S3"]).should eq [75, 71, 83]
      board.find_letters(["K1", "G2", "S3"]).should_not eq [1, 2, 3]
    end

    it "can check if the number of coordinates and the ship length" do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)

      board.coordinate_equal?(cruiser, ["A1", "V28", "N11"]).should eq true
      board.coordinate_equal?(cruiser, ["A1", "V28"]).should eq false
      board.coordinate_equal?(submarine, ["S14", "I11"]).should eq true
      board.coordinate_equal?(submarine, ["S14", "I11", "T23"]).should eq false
    end

    it "can check if the coordinates are already taken" do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)
      coordinates1 = ["A1", "A2", "A3"]
      coordinates2 = ["A1", "B1"]

      board.make_cells
      board.not_overlapping?(coordinates1).should eq true
      board.not_overlapping?(coordinates1).should_not eq false

      if board.not_overlapping?(coordinates1)
        board.@cells.each do |coordinate, cell|
          if coordinates1.includes?(coordinate)
            cell.place_ship(cruiser)
          end
        end
      end

      board.@cells["A1"].empty?.should eq false
      board.@cells["A2"].empty?.should eq false
      board.@cells["A3"].empty?.should eq false

      board.not_overlapping?(coordinates2).should eq false
      board.not_overlapping?(coordinates2).should_not eq true
    end

    it "can check that all the coordinates of the placement are valid" do
      board = Board.new

      coordinates1 = ["A1", "A2", "A3"]
      coordinates2 = ["A1", "B1"]
      coordinates3 = ["R1", "Q1"]
      coordinates4 = ["A7", "A8", "A9"]

      coordinates1.all? do |coordinate|
        board.valid_coordinate?(coordinate).should eq true
      end

      coordinates2.all? do |coordinate|
        board.valid_coordinate?(coordinate).should eq true
      end

      coordinates3.all? do |coordinate|
        board.valid_coordinate?(coordinate).should eq false
      end

      coordinates4.all? do |coordinate|
        board.valid_coordinate?(coordinate).should eq false
      end
    end

    it "can validate that a single coordinate is on the board" do
      board = Board.new

      board.valid_coordinate?("A1").should eq true
      board.valid_coordinate?("D4").should eq true
      board.valid_coordinate?("R1").should eq false
      board.valid_coordinate?("Z1").should eq false
      board.valid_coordinate?("A5").should eq false
      board.valid_coordinate?("F1").should eq false
    end
  end
end
