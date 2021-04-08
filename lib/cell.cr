class Cell
  getter coordinate : String
  # getter ship : Nil | Ship
  getter ship : Ship?
  getter fired_upon : Bool

  def initialize(coordinate)
    @coordinate = coordinate
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

  def fired_upon
    # debugger
    # @ship
    if @ship != nil
      # @ship.hit
      # print @ship
    end
    @fired_upon = true
  end
end
