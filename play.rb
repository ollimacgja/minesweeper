require './models/ui_printer.rb'
require './models/information_printer.rb'
require './models/cell.rb'
require './models/mine_sweeper.rb'

system('clear')
p "Insira a Largura do Campo Minado"
width = gets.chomp.to_i
p "Insira a Altura do Campo Minado"
height = gets.chomp.to_i
p "Insira a quantidade de bombas do Campo Minado"
bombs = gets.chomp.to_i

game = MineSweeper.new(width, height, bombs)

while game.still_playing?
  system('clear')
  UiPrinter.new.print_status(game.board_state)
  print "\n\nVoce deseja colocar uma bandeira ou jogar?\nDigite play para jogar ou flag para colocar uma bandeira.\n"
  action = gets.chomp
  print "\nAgora diga qual linha você deseja escolher. Lembre-se a primeira linha é a linha 0\n"
  x = gets.chomp.to_i
  print "\nAgora diga qual coluna você deseja escolher. Lembre-se a primeira coluna é a coluna 0\n"
  y = gets.chomp.to_i
  redo unless action == ('play'||'flag')
  valid_move = eval("game.#{action}(#{x},#{y})")
  if valid_move
    p 'movimento valido'
  end
end

puts "Fim do jogo!"
if game.victory?
  puts "Você venceu!"
else
  puts "Você perdeu! As minas eram:"
end
UiPrinter.new.print_status(game.board_state(xray: true))

# UiPrinter.new.print_ui(game.board_state)