defmodule ChessGround.BoardTest do
  alias ChessGround.Board
  alias ChessGround.Pieces


  use ExUnit.Case, async: true

  setup _context do
    {:ok, pid} = Board.new_board

    [pid: pid]
  end

  test "confirm ability to fertch the board", context do
    pid = context[:pid]
    state = GenServer.call(pid, :return_state)
    assert Map.keys(state) |> Enum.sort == [:board, :pieces]


    defaults_pieces = Pieces.starting_values()
    assert Map.equal?(defaults_pieces, state.pieces)

    starting_board = Board.starting_board()
    assert Map.equal?(starting_board, state.board)
  end

  test "confirm ability to return chosen fields", context do
    pid = context[:pid]

    pattern = %{
      {1, 1} => %{colour: :white, coordinates: {1, 1}, type: :tower},
      {1, 3} => %{colour: :white, coordinates: {1, 3}, type: :bishop},
      {1, 4} => %{colour: :white, coordinates: {1, 4}, type: :queen},
      {2, 2} => %{colour: :white, coordinates: {2, 2}, type: :pawn},
      {3, 1} => nil,
      {4, 2} => nil,
      {5, 5} => nil,
      {6, 1} => nil,
      {7, 2} => %{colour: :black, coordinates: {7, 2}, type: :pawn},
      {7, 8} => %{colour: :black, coordinates: {7, 8}, type: :pawn},
      {8, 1} => %{colour: :black, coordinates: {8, 1}, type: :tower}
    }

    result = Board.return_fields([{1,1}, {2,2}, {1,3}, {1,4}, {3,1}, {4,2}, {5,5}, {6,1}, {7,8}, {8,1}, {7,2}], pid)
  assert Map.equal?(pattern, result)

  end


end
