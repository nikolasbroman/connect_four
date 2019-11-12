class ConnectFour
  attr_accessor :grid

  def initialize
    setup
    @player = "x"
  end

  def play
    print_opening_message
    new_round
  end

  def print_opening_message
    puts
    puts
    puts "|||||||||||||                |||||||||||||"
    puts "||||||||||||| CONNECT FOUR   |||||||||||||"
    puts "|||||||||||||                |||||||||||||"
    puts "||||||||||||| programmed by  |||||||||||||"
    puts "||||||||||||| Nikolas Broman |||||||||||||"
    puts "|||||||||||||                |||||||||||||"
    puts
    puts "------------- The Rules ------------------"
    puts
    puts "Your mission is to connect four Xs or Os"
    puts "horizontally, verically or diagonally."
    puts
    puts "The first player to succeed wins."
    puts "Good luck!"
    puts
    puts "------------------------------------------"
    puts
  end

  def new_round
    winning_player = nil

    puts
    puts "A new round begins."
    puts
    puts grid_to_s
    puts

    loop do
      @player == "x" ? @player = "o" : @player = "x"
      puts "Player #{@player}: "
      drop_into_column(get_column_from_player, @player)
      puts
      puts grid_to_s
      puts
      winning_player = check_victory
      break unless winning_player.nil?
    end

    puts
    puts "Player #{winning_player} wins!"
    puts
    puts "Play a new round? (yes/no)"
    loop do
      input = gets.chomp.downcase
      case input
      when "yes", "y"
        setup
        new_round
        return
      when "no", "n"
        break
      else
        puts "I couldn't understand you, please try again: (yes/no)"
      end
    end
    puts
    puts "Thank you for playing."
    puts
  end

  def setup
    @grid = Array.new(6){ Array.new(7, " ") }
  end
  
  def drop_into_column(c, value)
    r = get_lowest_row_from_column(c)
    insert_into_position(r, c, value) unless r.nil?
    return r
  end

  def insert_into_position(r, c, value)
    @grid[r][c] = value
  end

  def get_lowest_row_from_column(c, r = 5)
    if r < 0
      return nil
    elsif @grid[r][c] == " "
      return r
    else
      return get_lowest_row_from_column(c, r-1)
    end
  end

  def print_grid(grid = @grid)
    puts
    grid.each { |row| p row }
    puts
  end

  def check_victory
    result = check_four_consecutives(@grid)
    result = check_four_consecutives(@grid.transpose) if result.nil?
    result = check_four_consecutives(diagonal_transpose(@grid)) if result.nil?
    result
  end

  def check_four_consecutives(grid)
    grid.each do |row|
      i = 1
      a = row[0]
      row[1..-1].each do |b|
        if a == b
          i += 1
        else
          i = 1
        end
        a = b
        break if i == 4 && a != " "
      end
      return a if i == 4 && a != " "
    end
    return nil
  end

  def diagonal_transpose(grid)
    diagonal_rows = []

    r = 0
    c = grid[0].length
    while r < grid.length
      r2 = r
      c2 = c
      new_row = []
      until grid[r2].nil? || grid[r2][c2].nil?
        new_row << grid[r2][c2]
        r2 += 1
        c2 += 1
      end
      diagonal_rows << new_row
      c > 0 ? c -= 1 : r += 1
    end

    r = 0
    c = 0
    while c < grid[0].length
      r2 = r
      c2 = c
      new_row = []
      until grid[r2].nil? || grid[r2][c2].nil?
        new_row << grid[r2][c2]
        r2 -= 1
        c2 += 1
      end
      diagonal_rows << new_row
      r == grid.length ? c += 1 : r += 1
    end

    diagonal_rows.select! { |row| row.length > 3}
    diagonal_rows
  end

  def get_column_from_player
    loop do
      column = gets.chomp.to_i - 1
      if column < 0 || column > 6
        puts "Please insert a valid column number (1-7):"
      elsif column_full?(column)
        puts "That column is full already. Please try again:"
      else
        return column
      end
    end
  end

  def column_full?(column)
    @grid.transpose[column][0] == " " ? false : true
  end

  def grid_to_s
    string = "  1 2 3 4 5 6 7  \n"
    @grid.each do |row|
      string += "| "
      row.each do |column|
        string += column + " "
      end
      string += "|\n"
    end
    string
  end
end

# If testing RSpec, comment out the lines below:
cf = ConnectFour.new
cf.play