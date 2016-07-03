class Cell
  attr_accessor :open, :value, :flag, :bomb

  def initialize(open=false,flag=false, bomb=false)
    @open, @flag, @bomb, @value = open, flag, bomb, 0
  end

  def set_flag
    @flag = true
  end

  def remove_flag
    @flag = false
  end

  def set_bomb
    @bomb = true
  end

  def open_cell
    @open = true
  end

  def increase_value
    @value += 1
  end

  def print_ui(options={})
    return "[# ]" if bomb && ( options[:xray] || open )
    return "[F ]" if flag
    return "[#{value.to_s} ]" if value != 0 && open
    return "[  ]" if open
    return "[..]"
  end
end