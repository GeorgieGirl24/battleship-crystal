class Board
  getter = @cells : Hash
  setter = @rows : Array
  setter = @columns : Array

  def initialize(board_size=4)
    @rows = Array(Int32).new
    @columns = Array(String).new
    @cells = Hash(String, Cell).new
    @cells = make_cells
  end

  def make_cells
    new_cells = Hash(String, Cell).new
    make_board_size.map do |key|
      new_cells[key] = Cell.new(key)
    end
    return new_cells
  end

  def make_board_size(board_size=4)
    alphabet = ("A".."Z").to_a
    @rows = (1..(board_size)).to_a
    @columns = ("A"..alphabet[board_size -1]).to_a
    coordinates = @columns.map do |letter|
      @rows.map do |number|
        letter + number.to_s
      end
    end
    coordinates.flatten
  end

  def valid_coordinate?(coordinate)
    @cells.keys.includes?(coordinate)
  end

  def all_valid_coordinates?(coordinates)
    coordinates.all? do |coordinate|
      valid_coordinate?(coordinate)
    end
  end

  def valid_placement?(ship, coordinates)
    coordinate_equal?(ship, coordinates) &&
    all_valid_coordinates?(coordinates) &&
    not_overlapping?(coordinates) &&
    (valid_numbers?(coordinates) || valid_letters?(coordinates))
  end

  def not_overlapping?(coordinates)
    coordinates.all? do |coordinate|
      @cells[coordinate].empty?
    end
  end

  def coordinate_equal?(ship, coordinates)
    ship.length == coordinates.size
  end

  def consecutive_numbers?(coordinates)
    set = @rows.each_cons(coordinates.size).to_a
    check = find_digits(coordinates).each_cons(coordinates.size).to_a.flatten
    set.any? do |group|
      group == check
    end
  end

  def consecutive_letters?(coordinates)
    set = make_letters_ord_numbers.each_cons(coordinates.size).to_a
    check = find_letters(coordinates).each_cons(coordinates.size).to_a.flatten
    set.any? do |group|
      group == check
    end
  end

  def find_digits(coordinates)
    coordinates.map do |coordinate|
      coordinate.delete(coordinate[0]).to_i
    end
  end

  def find_letters(coordinates)
    coordinates.map do |coordinate|
      letter = coordinate.each_char.@reader.@current_char
      if letter != Int
        letter.ord
      end
    end
  end

  def make_letters_ord_numbers
    @columns.map do |letter|
      letter.chars.map do |char|
        char.ord
      end
    end.flatten
  end

  def valid_numbers?(coordinates)
    consecutive_numbers?(coordinates) && all_letters_same?(coordinates)
  end

  def valid_letters?(coordinates)
    consecutive_letters?(coordinates) && all_numbers_same?(coordinates)
  end

  def all_letters_same?(coordinates)
    find_letters(coordinates).uniq.size == 1
  end

  def all_numbers_same?(coordinates)
    find_digits(coordinates).uniq.size == 1
  end
end
