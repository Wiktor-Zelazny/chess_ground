defmodule ChessGround.Board do
  use GenServer
  alias ChessGround.Pieces

  @starting_pieces Pieces.starting_values()

  def init(map) do
    {:ok, map}
  end

  def handle_call(:return_state, _, state) do #covered
    {:reply, state, state}
  end

  def handle_call({:return_state}, _, state) do
    {:reply, state, state}
  end

  def handle_call({:return_state, _arg}, _, state) do
    {:reply, state, state}
  end

  # def handle_cast({:update,{{x1,y1}, {x2,y2}}}, state) do
  #   IO.puts("Moving the piece")
  #   board = state.board
  #   pieces = state.pieces
  #   piece1 = Map.get(board, {x1, y1})
  #   piece2 = Map.get(board, {x2, y2})

  #   new_board = board
  #   |> Map.put({x2,y2}, piece)
  #   |> Map.put({x1, y1}, nil)

  #   new_pieces = piecesa
  #   |>


  #   new_state = state
  #     Map.put(:board, new_board)
  #     Map.put(:pieces, new_pieces)

  #   {:noreply, new_state}
  # end

  # defp maybe_kill_piece(pieces, key) do
  #   piece =
  # end


  def new_board, do: GenServer.start_link(ChessGround.Board,%{board: ChessGround.Board.starting_board, pieces: @starting_pieces})

  def return_fields(keylist, pid) do #covered
    state =  GenServer.call(pid, :return_state)

    state.board
    |> Map.take(keylist)
    |> Enum.map(fn {x, int} -> {x, Map.get(state.pieces, int)} end)
    |> Map.new
  end

  def move_piece({x1,y1}, {x2,y2}, pid) do
    state =  GenServer.call(pid, :return_state)
    board = state.board
    pieces = state.pieces

    piece1 = Map.get(board, {x1,y1})
    piece2 = Map.get(board, {x2, y2})
    detail1 = Map.get(pieces, piece1)
    detail2 = Map.get(pieces, piece2)

    case {detail1, detail2} do
      {nil, _ } ->  :illegal_move
      {}
    end



    fields = return_fields([{x1,y1}, {x2,y2}], pid) |> IO.inspect(label: "Fields")

    value1 = Map.get(fields, {x1,y1}) |> IO.inspect(label: "Value 1")
    value2 = Map.get(fields, {x2,y2}) |> IO.inspect(label: "Value 2")

    with {{_, _}, colour1, _} <- value1,
         true <- is_nil_or_hostile(value2, colour1) do
          GenServer.cast(pid, {:update, {{x1,y1}, {x2,y2}}})
         else
          _ -> :illegal_move
         end
  end

  def is_nil_or_hostile({{_, _}, colour2, _}, colour1), do: not colour1 == colour2
  def is_nil_or_hostile(nil, _), do: true
  def is_nil_or_hostile(_,_), do: false

  def starting_board do #covered
    initial_board =
      Enum.reduce(@starting_pieces, %{}, fn {piece, %{coordinates: {x, y}}}, acc ->
        Map.put(acc, {x, y}, piece)
      end)

    empty_fields = for x <- 3..6, y <- 1..8, do: {x, y}

    _starting_board =
      Enum.reduce(empty_fields, initial_board, fn {x, y}, acc -> Map.put(acc, {x, y}, nil) end)
  end

  def draw_board_debug(board, pieces) do
    for x <- 1..8 do
      Enum.reduce(1..8, to_string(x), fn y, acc ->
        acc <> "|" <> stringify(x, y, board, pieces)
      end)
      |> IO.puts()
    end
  end

  defp stringify(x, y, board, pieces) do
    case Map.get(pieces, Map.get(board, {x, y})) do
      %{coordinates: {^x, ^y}, colour: colour, type: type} -> to_string(colour) <> " " <> to_string(type)
      nil -> "         "
      _ -> "ERROR"
    end
  end
end
