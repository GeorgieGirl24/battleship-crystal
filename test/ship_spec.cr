require "spec"
require "../lib/ship"

describe Ship do
  describe "#ship_attributes" do
    it "has a length" do
      cruiser = Ship.new("Cruiser", 3)
      cruiser.length.should eq 3
      cruiser.length.should_not eq 2
      cruiser.length.should_not eq 4
    end

    it "has a health" do
      cruiser = Ship.new("Cruiser", 3)
      cruiser.health.should eq 3
      cruiser.health.should_not eq 4
      cruiser.health.should_not eq 2
    end

    it "has a name" do
      cruiser = Ship.new("Cruiser", 3)
      cruiser.name.should be "Cruiser"
      cruiser.name.should_not be "Submarine"
    end

    it "begins as an unsunken vessel" do
      cruiser = Ship.new("Cruiser", 3)
      cruiser.sunk.should eq false
      cruiser.sunk.should_not eq true
    end
  end

  describe "Ship can become sunk" do
    it "starts as being unsunk" do
      cruiser = Ship.new("Cruiser", 3)
      cruiser.sunk?.should eq false
      cruiser.sunk?.should_not eq true
    end

    it "can be hit and not sunk" do
      cruiser = Ship.new("Cruiser", 3)
      cruiser.health.should eq 3
      cruiser.hit
      cruiser.health.should eq 2
      cruiser.sunk?.should eq false
      cruiser.sunk?.should_not eq true
    end

    it "can be hit several times" do
      cruiser = Ship.new("Cruiser", 3)
      cruiser.health.should eq 3
      cruiser.hit
      cruiser.hit
      cruiser.health.should eq 1
      cruiser.sunk?.should eq false
      cruiser.sunk?.should_not eq true
    end

    it "can be hit the same number of times as health and become sunk" do
      cruiser = Ship.new("Cruiser", 3)
      cruiser.health.should eq 3
      cruiser.hit
      cruiser.hit
      cruiser.hit
      cruiser.health.should eq 0
      cruiser.sunk?.should eq true
      cruiser.sunk?.should_not eq false
    end
  end
end
