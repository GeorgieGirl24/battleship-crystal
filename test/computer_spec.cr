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

  describe "target" do

  end
end
