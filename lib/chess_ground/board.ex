defmodule ChessGround.Board do

alias ChessGround.Pieces

@starting_pieces Pieces.starting_values()


def starting_board do
initial_board = Enum.reduce(@starting_pieces, %{}, fn {piece, {{x,y},_,_}}, acc -> Map.put(acc, {x,y}, piece) end)

empty_fields = for x <- 3..6, y <- 1..8, do: {x,y}

_starting_board = Enum.reduce(empty_fields, initial_board, fn {x,y}, acc -> Map.put(acc, {x,y}, nil)end)

end

def draw_board_debug(board, pieces) do
  for x <-1..8 do

    Enum.reduce(1..8, to_string(x), fn y, acc -> acc <> "|" <> stringify(x,y, board, pieces) end)
    |> IO.puts
    # for y <- 1..8 do



    #   IO.puts(" | ")
    # end

    # IO.inspect(x)
    # IO.puts("\n")
  end
end

defp stringify(x,y,board, pieces) do
  case Map.get(pieces, Map.get(board, {x,y})) do
    {{^x,^y}, colour, name} -> to_string(colour) <> " " <>to_string(name)
    _ -> "         "
  end
end

end
