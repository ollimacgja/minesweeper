class InformationPrinter
  def print_status(game_status, board_status, vitory)
    {
      still_playing: game_status,
      victory: victory,
      board_state:{
        unknown_cells: board_status.scan('[.]').count,
        flagged_cells: board_status.scan('[F]').count,
        cleared_cells: board_status.scan('[ ]').count + board_status.scan(/\d/).count,
        bomb_cells: board_status.scan('[#]').count

      }
    }
  end
end