defmodule ChessGround.Pieces do
 @starting_values %{
  1 => {{8,1}, :black, :tower},
  2 => {{8,2}, :black, :knight},
  3 => {{8,3}, :black, :bishop},
  4 => {{8,4}, :black, :queen},
  5 => {{8,5}, :black, :king},
  6 => {{8,6}, :black, :bishop},
  7 => {{8,7}, :black, :knight},
  8 => {{8,8}, :black, :tower},
  11 => {{7,1}, :black,  :pawn},
  12 => {{7,2}, :black, :pawn},
  13 => {{7,3}, :black, :pawn},
  14 => {{7,4}, :black, :pawn},
  15 => {{7,5}, :black, :pawn},
  16 => {{7,6}, :black, :pawn},
  17 => {{7,7}, :black, :pawn},
  18 => {{7,8}, :black, :pawn},
  81 => {{1,1}, :white, :pawn},
  82 => {{1,2}, :white, :pawn},
  83 => {{1,3}, :white, :pawn},
  84 => {{1,4}, :white, :pawn},
  85 => {{1,5}, :white, :pawn},
  86 => {{1,6}, :white, :pawn},
  87 => {{1,7}, :white, :pawn},
  88 => {{1,8}, :white, :pawn},
  91 => {{2,1}, :white, :tower},
  92 => {{2,2}, :white, :knight},
  93 => {{2,3}, :white, :bishop},
  94 => {{2,4}, :white, :queen},
  95 => {{2,5}, :white, :king},
  96 => {{2,6}, :white, :bishop},
  97 => {{2,7}, :white, :knight},
  98 => {{2,8}, :white, :tower}
 }

 def starting_values, do: @starting_values


 def maybe_upgrage_to_queen({{1,y}, :black, :pawn}), do: {:new_value, {{1,y}, :black, :queen}}
 def maybe_upgrage_to_queen({{8,y}, :white, :pawn}), do: {:new_value, {{8,y}, :white, :queen}}
 def maybe_upgrage_to_queen(_), do: {:no_change, {}}



end
