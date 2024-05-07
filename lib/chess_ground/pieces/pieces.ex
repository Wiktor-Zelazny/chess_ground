defmodule ChessGround.Pieces do
  alias ChessGround.Board
  @starting_values %{
    1 => {{8, 1}, :black, :tower},
    2 => {{8, 2}, :black, :knight},
    3 => {{8, 3}, :black, :bishop},
    4 => {{8, 4}, :black, :queen},
    5 => {{8, 5}, :black, :king},
    6 => {{8, 6}, :black, :bishop},
    7 => {{8, 7}, :black, :knight},
    8 => {{8, 8}, :black, :tower},
    11 => {{7, 1}, :black, :pawn},
    12 => {{7, 2}, :black, :pawn},
    13 => {{7, 3}, :black, :pawn},
    14 => {{7, 4}, :black, :pawn},
    15 => {{7, 5}, :black, :pawn},
    16 => {{7, 6}, :black, :pawn},
    17 => {{7, 7}, :black, :pawn},
    18 => {{7, 8}, :black, :pawn},
    81 => {{2, 1}, :white, :pawn},
    82 => {{2, 2}, :white, :pawn},
    83 => {{2, 3}, :white, :pawn},
    84 => {{2, 4}, :white, :pawn},
    85 => {{2, 5}, :white, :pawn},
    86 => {{2, 6}, :white, :pawn},
    87 => {{2, 7}, :white, :pawn},
    88 => {{2, 8}, :white, :pawn},
    91 => {{1, 1}, :white, :tower},
    92 => {{1, 2}, :white, :knight},
    93 => {{1, 3}, :white, :bishop},
    94 => {{1, 4}, :white, :queen},
    95 => {{1, 5}, :white, :king},
    96 => {{1, 6}, :white, :bishop},
    97 => {{1, 7}, :white, :knight},
    98 => {{1, 8}, :white, :tower}
  }

  def mapify({{x, y}, colour, type}), do: %{coordinates: {x,y}, colour: colour, type: type}

  def starting_values, do: @starting_values |> Enum.map(fn {key, value} -> {key, mapify(value)} end) |> Map.new


  def maybe_upgrage_to_queen({{1, y}, :black, :pawn}), do: {:new_value, {{1, y}, :black, :queen}}
  def maybe_upgrage_to_queen({{8, y}, :white, :pawn}), do: {:new_value, {{8, y}, :white, :queen}}
  def maybe_upgrage_to_queen(_), do: {:no_change, {}}

  # def generate_moves({{x, y}, :white, :pawn}, pid) do
  #   move =
  #     [{x+1,y}]
  #     |> apply_board_borders
  #     |> Board.return_fields(pid)
  #     |> Enum.filter(fn {_, x} -> is_nil(x) end)

  #   attack = [{x+1,y+1}, {x+1, y-1}]
  #   |> apply_board_borders
  #   |> Board.return_fields(pid)
  #   |> Enum.filter(fn {_, x} -> is_friendly(x, :black) end)

  #   move ++ attack
  # end


  def generate_moves(%{colour: :white, coordinates: {x, y}, type: :pawn}, pid) do
    move =
      [{x+1,y}]
      |> apply_board_borders
      |> Board.return_fields(pid)
      |> Enum.filter(fn {_, x} -> is_nil(x) end)

    attack = [{x+1,y+1}, {x+1, y-1}]
    |> apply_board_borders
    |> Board.return_fields(pid)
    |> Enum.filter(fn {_, x} -> is_friendly(x, :black) end)

    move ++ attack
  end

  def generate_moves(%{colour: :black, coordinates: {x, y}, type: :pawn}, pid) do
    move =
      [{x-1,y}]
      |> apply_board_borders
      |> Board.return_fields(pid)
      |> Enum.filter(fn {_, x} -> is_nil(x) end)


    attack = [{x-1,y+1}, {x-1, y-1}]
    |> IO.inspect(label: "A1")
    |> apply_board_borders
    |> Board.return_fields(pid)
    |> Enum.filter(fn {_, x} -> is_friendly(x, :white) end)


    move ++ attack
  end#ZJE -BA - NY KOD!!!!!!

  def generate_moves(%{colour: colour, coordinates: {x, y}, type: :knight}, pid) do
    [{x+2, y+1},
     {x+2, y-1},
     {x-2, y+1},
     {x-2, y-1},
     {x+1, y+2},
     {x-1, y+2},
     {x+1, y-2},
     {x-1, y-2}
    ]
    |> apply_board_borders
    |> Board.return_fields(pid)
    |> Enum.filter(fn {_, x} -> not is_friendly(x, colour) end)
  end

  # def generate_moves({{x, y}, :white, :horse}, pid) do
  #   [{x+2, y+1},
  #    {x+2, y-1},
  #    {x-2, y+1},
  #    {x-2, y-1},
  #    {x+1, y+2},
  #    {x-1, y+2},
  #    {x+1, y-2},
  #    {x-1, y-2}
  #   ]
  #   |> apply_board_borders
  #   |> Board.return_fields(pid)
  #   |> Enum.filter(fn {_, x} -> not is_white(x) end)
  # end

  def generate_moves(%{colour: colour, coordinates: {x, y}, type: :tower} , pid) do

    upqueue = for z <- 1.. 7 do {x+z, y} end
    |> fetch_and_trim_range(pid, colour)

    downqueue = for z <- 1.. 7 do {x-z, y} end
    |> fetch_and_trim_range(pid, colour)

    leftqueue = for z <- 1.. 7 do {x, y-z} end
    |> fetch_and_trim_range(pid, colour)

    rightqueue = for z <- 1.. 7 do {x, y+z} end
    |> fetch_and_trim_range(pid, colour)

    upqueue ++ downqueue ++ rightqueue ++ leftqueue
  end

  def generate_moves(%{colour: colour, coordinates: {x, y}, type: :bishop}, pid) do

    uprightqueue = for z <- 1.. 7 do {x+z, y+z} end
    |> fetch_and_trim_range(pid, colour)

    downrightqueue = for z <- 1.. 7 do {x-z, y+z} end
    |> fetch_and_trim_range(pid, colour)

    upleftqueue = for z <- 1.. 7 do {x+z, y-z} end
    |> fetch_and_trim_range(pid, colour)

    downlefttqueue = for z <- 1.. 7 do {x-z, y-z} end
    |> fetch_and_trim_range(pid, colour)

    uprightqueue ++ downrightqueue ++ upleftqueue ++ downlefttqueue
  end

  def generate_moves(%{colour: colour, coordinates: {x, y}, type: :queen}, pid) do
    generate_moves(%{colour: colour, coordinates: {x, y}, type: :tower}, pid) ++ generate_moves(%{colour: colour, coordinates: {x, y}, type: :bishop}, pid)
  end

  def generate_moves(%{colour: colour, coordinates: {x, y}, type: :king}, pid)  do
    [
      {x+1,y},
      {x-1,y},
      {x,y+1},
      {x,y-1},
      {x+1,y+1},
      {x+1,y-1},
      {x-1,y+1},
      {x-1,y-1}
    ]
    |> apply_board_borders
    |> Board.return_fields(pid)
    |> Enum.filter(fn {_, x} -> not is_friendly(x, colour) end)
  end



  # defp is_black({{_, _}, :black, _}), do: true
  # defp is_black(_), do: false
  # defp is_white({{_, _}, :white, _}), do: true
  # defp is_white(_), do: false

  defp is_friendly(%{colour: colour1}, colour2), do: colour1 == colour2
  defp is_friendly(_, _), do: false

  def valid_coordinates({x,y}) do
    x > 0 and x <9 and y >0 and y < 9
  end

  def apply_board_borders(list) do
    list
    |> Enum.filter(fn  x -> valid_coordinates(x)end)
  end

  def trim_range([], out_list, _), do: out_list
  def trim_range([{{x, y}, nil} | tail], out_list, colour), do: trim_range(tail, [{{x, y}, nil} | out_list],  colour)

  # def trim_range([{{x, y}, piece} | _], out_list, :black) do
  #   IO.inspect(out_list, label: "DUPA")
  #    if is_white(piece) do
  #      [{{x, y}, piece} | out_list]
  #    else
  #     out_list
  #    end
  # end

  def trim_range([{{x, y}, piece} | _], out_list, colour) do
    if is_friendly(piece, colour) do
      out_list
    else
      [{{x, y}, piece} | out_list]
    end
 end

 def fetch_and_trim_range(list, pid, colour) do
  fields = apply_board_borders(list)

  board = Board.return_fields(fields, pid)

  fields
  |> Enum.map(fn coord -> {coord, Map.get(board, coord)}end) #to enforce ordering of retuenrd fields
  |> trim_range([], colour)
 end


end
