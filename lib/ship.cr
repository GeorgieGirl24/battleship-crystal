class Ship
  getter name : String
  getter length : Int32
  getter health : Int32
  getter sunk : Bool

  def initialize(name, length)
    @name = name
    @length = length
    @health = length
    @sunk = false
  end

  def sunk?
    @sunk = @health == 0
  end

  def hit
    @health -= 1
  end
end
