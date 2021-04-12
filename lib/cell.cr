# require "./ship"
class Cell
  getter coordinate : String
  property coordinate
  # getter ship : Ship
  # getter ship : Nil | Ship
  property ship
  setter ship : Ship?
  getter fired_upon : Bool
  # property fired_upon

  def initialize(@coordinate : String)
    # @coordinate = coordinate
    @ship = nil
    @fired_upon = false
  end

  def empty?
    @ship.nil?
  end

  def place_ship(ship_type)
    @ship = ship_type
  end

  def fired_upon?
    @fired_upon
  end

  def fire_upon
    if !@ship.nil?
      if s = @ship
        s.hit
      end
    end
    @fired_upon = true
  end
end
