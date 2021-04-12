class Cell
  property coordinate
  property ship
  setter ship : Ship?
  getter fired_upon : Bool

  def initialize(@coordinate : String)
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

  def render(visible=false)
      if !empty? && !fired_upon? && visible == true
        "S"
      elsif s = @ship
        if !empty? && s.sunk? && fired_upon?
          "X"
        elsif !empty? && fired_upon? && !s.sunk?
          "H"
        end
      elsif empty? && fired_upon?
        "M"
      elsif empty? || !fired_upon?
        "."
      end
  end
end
