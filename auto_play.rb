require './models/ui_printer.rb'
require './models/information_printer.rb'
require './models/cell.rb'
require './models/mine_sweeper.rb'

width, height, num_mines = 20, 20, 50
game = MineSweeper.new(width, height, num_mines)

while game.still_playing?
  valid_move = game.play(rand(width), rand(height))
  valid_flag = game.flag(rand(width), rand(height))
  if valid_move or valid_flag
    UiPrinter.new.print_status(game.board_state)
    p '---------------------------------------------'
  end
end

puts "Fim do jogo!"
if game.victory?
  puts "Você venceu!"
else
  puts "Você perdeu! As minas eram:"
  UiPrinter.new.print_status(game.board_state(xray: true))
end

# UiPrinter.new.print_ui(game.board_state)