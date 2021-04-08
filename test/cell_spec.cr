require "spec"
require "../lib/ship"
require "../lib/cell"

describe Cell do
  describe "has attributes" do
    it "has a coordinate" do
      cell = Cell.new("B4")
      cell.coordinate.should eq "B4"
      cell.coordinate.should_not eq "B5"
    end

    it "has no ship to start with" do
      cell = Cell.new("B4")
      cell.ship.should eq nil
    end

    it "is empty with no ship in it" do
      cell = Cell.new("B4")
      cell.empty?.should eq true
      cell.empty?.should_not eq false
    end
  end

  describe "Cells can be fired upon and can have ships" do
    it "can place a ship" do
      cell = Cell.new("B4")
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)

      cell.place_ship(cruiser)
      cell.ship.should eq cruiser
      cell.ship.should_not eq submarine
    end

    it "can place a ship and the cell is not empty" do
      cell = Cell.new("B4")
      cruiser = Ship.new("Cruiser", 3)

      cell.place_ship(cruiser)
      cell.empty?.should eq false
      cell.empty?.should_not eq true
    end

    it "starts with not being fired upon" do
      cell = Cell.new("B4")
      cruiser = Ship.new("Cruiser", 3)

      # cell.fired_upon.should eq false
      # cell.fired_upon.should_not eq true
    end

    it "can be fired upon and that takes away the health of the ship" do
      cell = Cell.new("B4")
      cruiser = Ship.new("Cruiser", 3)

      cell.place_ship(cruiser)
      p cell.ship
      p cruiser.health
      cell.fired_upon
      cell.empty?.should eq false
      p cell.coordinate
      p cell.ship
      # cell.ship.health.should eq 2
    end

    it "can only decrease the health of the ship by one with every hit" do
      cell = Cell.new("B4")
      cruiser = Ship.new("Cruiser", 3)

    end

    it "can change fired_upon? when it has in fact been fired upon" do
      cell = Cell.new("B4")
      cruiser = Ship.new("Cruiser", 3)

    end

    it "can can render a 'H' when a cell is hit with a ship on it" do
      cell = Cell.new("B4")
      cruiser = Ship.new("Cruiser", 3)

    end

    it "can can render a '.' when a cell is empty and not fired upon" do
      cell = Cell.new("B4")
      cruiser = Ship.new("Cruiser", 3)

    end

    it "can can render a 'M' when a cell is hit with no ship on it" do
      cell = Cell.new("B4")
      cruiser = Ship.new("Cruiser", 3)

    end

    it "can can render a 'M' when a cell is hit with no ship on it" do
      cell = Cell.new("B4")
      cruiser = Ship.new("Cruiser", 3)

    end

    it "can can render a 'X' when a cell is hit with a ship on it and is sunk" do
      cell = Cell.new("B4")
      cruiser = Ship.new("Cruiser", 3)

    end

    it "can show optional visability" do
      cell = Cell.new("B4")
      cruiser = Ship.new("Cruiser", 3)

    end

  end
end
