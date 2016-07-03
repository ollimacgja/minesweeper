class MineSweeper
  attr_accessor :board, :end_game, :victory, :remaining_cells

  def initialize(width, height, bombs)
    @height, @width, @bombs, @end_game, @victory, @remaining_cells = height, width, bombs, false, false, height * width
    start_game
  end

  def start_game
    build_board
    place_bombs
  end

  def play(x, y)
    return false if x > @width || y > @height|| board[x][y].open || board[x][y].flag || !still_playing?
    if board[x][y].bomb
      board[x][y].open_cell
      @end_game = true
    else
      open_surrounding_cells(x,y)
    end
    check_victory
    return true
  end

  def check_victory
    if @remaining_cells == @bombs
      @victory = true
      @end_game = true
    end
  end

  def victory?
    @victory
  end

  def flag(x,y)
    return false if x > @width || y > @height || board[x][y].open
    board[x][y].flag ? board[x][y].remove_flag : board[x][y].set_flag
    return true
  end

  def still_playing?
    @end_game == false
  end

  def build_board
    @board = []
    (0..@width - 1).each do |i|
      board[i] = []
      (0..@height - 1).each do |j|
        board[i][j] = Cell.new
      end
    end
  end

  def board_state(options={})
    options = {} unless still_playing? == false
    stat = "[xx]"
    (0..@width-1).each {|a| stat <<  "[#{a.to_s.rjust(2,'0')}]"}
    stat << "\n"
    board.each_with_index do |x,i|
      stat << "[#{i.to_s.rjust(2, '0')}]"
      x.each do |y|
        stat << y.print_ui(options)
      end
      stat << "\n"
    end
    stat
  end

  def place_bombs
    (1..@bombs).each do |i|
      x = rand(@width)
      y = rand(@height)
      if board[x][y].bomb
        redo
      else
        board[x][y].set_bomb
        change_surrounding_values(get_surroundings(x, y))
      end

    end
  end

  def get_surroundings(x, y)
    positions = []
    (-1..1).each do |i|
      x_axis = x + i
      if board[x_axis] && x_axis >= 0
        (-1..1).each do |j|
          y_axis = y + j
          if board[x_axis][y_axis] && y_axis >= 0
            positions << [x_axis, y_axis] unless ( x_axis == x && y_axis == y )
          end
        end
      end
    end
    positions
  end

  def change_surrounding_values(array)
    array.each do |x, y|
      board[x][y].increase_value
    end
  end

  def open_surrounding_cells(x,y)
    if board[x][y].open == true
      return
    else
      board[x][y].open_cell
      @remaining_cells -= 1
      if board[x][y].value == 0
        get_surroundings(x, y).each do |i,j|
          open_surrounding_cells(i,j)
        end
      end
    end
  end
end