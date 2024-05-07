defmodule ChessGround.PiecesTest do
  alias ChessGround.Board
  alias ChessGround.Pieces


  use ExUnit.Case, async: true

  setup _context do
    {:ok, pid} = Board.new_board

    [pid: pid]
  end

  test "verify black pawn moves", context do
    pid = context[:pid]

    pb71 = Pieces.generate_moves( %{colour: :black, coordinates: {7, 1}, type: :pawn}, pid)
    assert pb71 == [{{6, 1}, nil}]

    pb61 = Pieces.generate_moves( %{colour: :black, coordinates: {6, 1}, type: :pawn}, pid)
    assert pb61 == [{{5, 1}, nil}]

    pb51 = Pieces.generate_moves( %{colour: :black, coordinates: {5, 1}, type: :pawn}, pid)
    assert pb51 == [{{4, 1}, nil}]

    pb41 = Pieces.generate_moves( %{colour: :black, coordinates: {4, 1}, type: :pawn}, pid)
    assert pb41 == [{{3, 1}, nil}]

    pb31 = Pieces.generate_moves( %{colour: :black, coordinates: {3, 1}, type: :pawn}, pid)
    assert pb31 == [{{2, 2}, %{colour: :white, coordinates: {2, 2}, type: :pawn}}]

    pb38 = Pieces.generate_moves( %{colour: :black, coordinates: {3, 8}, type: :pawn}, pid)
    assert pb38 == [{{2, 7}, %{colour: :white, coordinates: {2, 7}, type: :pawn}}]

    pb32 = Pieces.generate_moves( %{colour: :black, coordinates: {3, 2}, type: :pawn}, pid)
           |> Enum.sort
    assert pb32 == [
      {{2, 1}, %{colour: :white, coordinates: {2, 1}, type: :pawn}},
      {{2, 3}, %{colour: :white, coordinates: {2, 3}, type: :pawn}}
    ]

  end


  test "verify white pawn moves", context do
    pid = context[:pid]

    pb21 = Pieces.generate_moves( %{colour: :white, coordinates: {2, 1}, type: :pawn}, pid)
    assert pb21 == [{{3, 1}, nil}]

    pb31 = Pieces.generate_moves( %{colour: :white, coordinates: {3, 1}, type: :pawn}, pid)
    assert pb31 == [{{4, 1}, nil}]

    pb41 = Pieces.generate_moves( %{colour: :white, coordinates: {4, 1}, type: :pawn}, pid)
    assert pb41 == [{{5, 1}, nil}]

    pb51 = Pieces.generate_moves( %{colour: :white, coordinates: {5, 1}, type: :pawn}, pid)
    assert pb51 == [{{6, 1}, nil}]

    pb61 = Pieces.generate_moves( %{colour: :white, coordinates: {6, 1}, type: :pawn}, pid)
    assert pb61 == [{{7, 2}, %{colour: :black, coordinates: {7, 2}, type: :pawn}}]

    pb68 = Pieces.generate_moves( %{colour: :white, coordinates: {6, 8}, type: :pawn}, pid)
    assert pb68 == [{{7, 7}, %{colour: :black, coordinates: {7, 7}, type: :pawn}}]

    pb62 = Pieces.generate_moves( %{colour: :white, coordinates: {6, 2}, type: :pawn}, pid)
           |> Enum.sort
    assert pb62 == [
      {{7, 1}, %{colour: :black, coordinates: {7, 1}, type: :pawn}},
      {{7, 3}, %{colour: :black, coordinates: {7, 3}, type: :pawn}}
    ]

  end

  test "verify knight pawn moves", context do
    pid = context[:pid]

    pb82 = Pieces.generate_moves( %{colour: :white, coordinates: {8, 2}, type: :knight}, pid)
    |> Enum.sort()
    # |> IO.inspect(label: "8,2")
    assert pb82 == [
      {{6, 1}, nil},
      {{6, 3}, nil},
      {{7, 4}, %{colour: :black, coordinates: {7, 4}, type: :pawn}}
    ]


    pb44 = Pieces.generate_moves( %{colour: :white, coordinates: {4, 4}, type: :knight}, pid)
    |> Enum.sort()
    # |> IO.inspect(label: "4,4")
    assert pb44 == [
      {{3, 2}, nil},
      {{3, 6}, nil},
      {{5, 2}, nil},
      {{5, 6}, nil},
      {{6, 3}, nil},
      {{6, 5}, nil}
    ]


    pb66 = Pieces.generate_moves( %{colour: :white, coordinates: {6, 6}, type: :knight}, pid)
    |> Enum.sort()
    # |> IO.inspect(label: "6,6")
    assert pb66 == [
      {{4, 5}, nil},
      {{4, 7}, nil},
      {{5, 4}, nil},
      {{5, 8}, nil},
      {{7, 4}, %{colour: :black, coordinates: {7, 4}, type: :pawn}},
      {{7, 8}, %{colour: :black, coordinates: {7, 8}, type: :pawn}},
      {{8, 5}, %{colour: :black, coordinates: {8, 5}, type: :king}},
      {{8, 7}, %{colour: :black, coordinates: {8, 7}, type: :knight}}
    ]


    pb12 = Pieces.generate_moves( %{colour: :black, coordinates: {1, 2}, type: :knight}, pid)
    |> Enum.sort()
    # |> IO.inspect(label: "1,2")
    assert pb12 == [
      {{2, 4}, %{colour: :white, coordinates: {2, 4}, type: :pawn}},
      {{3, 1}, nil},
      {{3, 3}, nil}
    ]


    pb55 = Pieces.generate_moves( %{colour: :black, coordinates: {5, 5}, type: :knight}, pid)
    |> Enum.sort()
    # |> IO.inspect(label: "5,5")
    assert pb55 == [
      {{3, 4}, nil},
      {{3, 6}, nil},
      {{4, 3}, nil},
      {{4, 7}, nil},
      {{6, 3}, nil},
      {{6, 7}, nil}
    ]



    pb68 = Pieces.generate_moves( %{colour: :black, coordinates: {3, 3}, type: :knight}, pid)
    |> Enum.sort()
    # |> IO.inspect()
    assert pb68 == [
      {{1, 2}, %{colour: :white, coordinates: {1, 2}, type: :knight}},
      {{1, 4}, %{colour: :white, coordinates: {1, 4}, type: :queen}},
      {{2, 1}, %{colour: :white, coordinates: {2, 1}, type: :pawn}},
      {{2, 5}, %{colour: :white, coordinates: {2, 5}, type: :pawn}},
      {{4, 1}, nil},
      {{4, 5}, nil},
      {{5, 2}, nil},
      {{5, 4}, nil}
    ]


  end

  test "verify tower moves", context do
    pid = context[:pid]

    pb11 = Pieces.generate_moves( %{colour: :white, coordinates: {1, 1}, type: :tower}, pid)
    |> Enum.sort()
    # |> IO.inspect(label: "1,1")
    assert pb11 == []

    pb11 = Pieces.generate_moves( %{colour: :black, coordinates: {1, 1}, type: :tower}, pid)
    |> Enum.sort()
    # |> IO.inspect(label: "1,1")
    assert pb11 == [{{1, 2}, %{colour: :white, coordinates: {1, 2}, type: :knight}}, {{2, 1}, %{colour: :white, coordinates: {2, 1}, type: :pawn}}]


    pb22 = Pieces.generate_moves( %{colour: :white, coordinates: {2, 2}, type: :tower}, pid)
    |> Enum.sort()
    # |> IO.inspect(label: "2,2")
    assert pb22 == [
      {{3, 2}, nil},
      {{4, 2}, nil},
      {{5, 2}, nil},
      {{6, 2}, nil},
      {{7, 2}, %{colour: :black, coordinates: {7, 2}, type: :pawn}}
    ]

    pb22 = Pieces.generate_moves( %{colour: :black, coordinates: {2, 2}, type: :tower}, pid)
    |> Enum.sort()
    # |> IO.inspect(label: "2,2")
    assert pb22 == [
      {{1, 2}, %{colour: :white, coordinates: {1, 2}, type: :knight}},
      {{2, 1}, %{colour: :white, coordinates: {2, 1}, type: :pawn}},
      {{2, 3}, %{colour: :white, coordinates: {2, 3}, type: :pawn}},
      {{3, 2}, nil},
      {{4, 2}, nil},
      {{5, 2}, nil},
      {{6, 2}, nil}
    ]



    pb44 = Pieces.generate_moves( %{colour: :white, coordinates: {4, 4}, type: :tower}, pid)
    |> Enum.sort()
    # |> IO.inspect(label: "4,4")
    assert pb44 == [
      {{3, 4}, nil},
      {{4, 1}, nil},
      {{4, 2}, nil},
      {{4, 3}, nil},
      {{4, 5}, nil},
      {{4, 6}, nil},
      {{4, 7}, nil},
      {{4, 8}, nil},
      {{5, 4}, nil},
      {{6, 4}, nil},
      {{7, 4}, %{colour: :black, coordinates: {7, 4}, type: :pawn}}
    ]

    pb41 = Pieces.generate_moves( %{colour: :black, coordinates: {4, 4}, type: :tower}, pid)
    |> Enum.sort()
    # |> IO.inspect(label: "4,4")
    assert pb41 == [
      {{2, 4}, %{colour: :white, coordinates: {2, 4}, type: :pawn}},
      {{3, 4}, nil},
      {{4, 1}, nil},
      {{4, 2}, nil},
      {{4, 3}, nil},
      {{4, 5}, nil},
      {{4, 6}, nil},
      {{4, 7}, nil},
      {{4, 8}, nil},
      {{5, 4}, nil},
      {{6, 4}, nil}
    ]
  end


  test "verify bishop moves", context do
    pid = context[:pid]

    pb71 = Pieces.generate_moves( %{colour: :black, coordinates: {8, 6}, type: :bishop}, pid)
    |> Enum.sort()
    # |> IO.inspect(label: "8,6")
    assert pb71 == []

    pb61 = Pieces.generate_moves( %{colour: :white, coordinates: {8, 6}, type: :bishop}, pid)
    |> Enum.sort()
    # |> IO.inspect(label: "8,6")
    assert pb61 == [
      {{7, 5}, %{colour: :black, coordinates: {7, 5}, type: :pawn}},
      {{7, 7}, %{colour: :black, coordinates: {7, 7}, type: :pawn}}
    ]

    pb51 = Pieces.generate_moves( %{colour: :black, coordinates: {3, 4}, type: :bishop}, pid)
    |> Enum.sort()
    # |> IO.inspect(label: "3,4 b")
    assert pb51 ==  [
      {{2, 3}, %{colour: :white, coordinates: {2, 3}, type: :pawn}},
      {{2, 5}, %{colour: :white, coordinates: {2, 5}, type: :pawn}},
      {{4, 3}, nil},
      {{4, 5}, nil},
      {{5, 2}, nil},
      {{5, 6}, nil},
      {{6, 1}, nil},
      {{6, 7}, nil}
    ]


    pb41 = Pieces.generate_moves( %{colour: :white, coordinates: {3, 4}, type: :bishop}, pid)
    |> Enum.sort()
    # |> IO.inspect(label: "3,4 w")
    assert pb41 ==  [
      {{4, 3}, nil},
      {{4, 5}, nil},
      {{5, 2}, nil},
      {{5, 6}, nil},
      {{6, 1}, nil},
      {{6, 7}, nil},
      {{7, 8}, %{colour: :black, coordinates: {7, 8}, type: :pawn}}
    ]
  end

  test "verify queen moves", context do
    pid = context[:pid]

    pb11 = Pieces.generate_moves( %{colour: :white, coordinates: {1, 1}, type: :queen}, pid)
    |> Enum.sort()
    # |> IO.inspect(label: "1,1")
    assert pb11 == []

    pb11 = Pieces.generate_moves( %{colour: :black, coordinates: {1, 1}, type: :queen}, pid)
    |> Enum.sort()
    |> IO.inspect(label: "1,1")
    assert pb11 == [{{1, 2}, %{colour: :white, coordinates: {1, 2}, type: :knight}},
                    {{2, 1}, %{colour: :white, coordinates: {2, 1}, type: :pawn}},
                    {{2, 2}, %{colour: :white, coordinates: {2, 2}, type: :pawn}}
                   ]


    pb22 = Pieces.generate_moves( %{colour: :white, coordinates: {2, 2}, type: :queen}, pid)
    |> Enum.sort()
    # |> IO.inspect(label: "2,2")
    assert pb22 == [
      {{3, 1}, nil},
      {{3, 2}, nil},
      {{3, 3}, nil},
      {{4, 2}, nil},
      {{4, 4}, nil},
      {{5, 2}, nil},
      {{5, 5}, nil},
      {{6, 2}, nil},
      {{6, 6}, nil},
      {{7, 2}, %{colour: :black, coordinates: {7, 2}, type: :pawn}},
      {{7, 7}, %{colour: :black, coordinates: {7, 7}, type: :pawn}}
    ]


    pb22 = Pieces.generate_moves( %{colour: :black, coordinates: {2, 2}, type: :queen}, pid)
    |> Enum.sort()
    # |> IO.inspect(label: "2,2")
    assert pb22 ==  [
      {{1, 1}, %{colour: :white, coordinates: {1, 1}, type: :tower}},
      {{1, 2}, %{colour: :white, coordinates: {1, 2}, type: :knight}},
      {{1, 3}, %{colour: :white, coordinates: {1, 3}, type: :bishop}},
      {{2, 1}, %{colour: :white, coordinates: {2, 1}, type: :pawn}},
      {{2, 3}, %{colour: :white, coordinates: {2, 3}, type: :pawn}},
      {{3, 1}, nil},
      {{3, 2}, nil},
      {{3, 3}, nil},
      {{4, 2}, nil},
      {{4, 4}, nil},
      {{5, 2}, nil},
      {{5, 5}, nil},
      {{6, 2}, nil},
      {{6, 6}, nil}
    ]




    pb44 = Pieces.generate_moves( %{colour: :white, coordinates: {4, 4}, type: :queen}, pid)
    |> Enum.sort()
    # |> IO.inspect(label: "4,4")
    assert pb44 == [
      {{3, 3}, nil},
      {{3, 4}, nil},
      {{3, 5}, nil},
      {{4, 1}, nil},
      {{4, 2}, nil},
      {{4, 3}, nil},
      {{4, 5}, nil},
      {{4, 6}, nil},
      {{4, 7}, nil},
      {{4, 8}, nil},
      {{5, 3}, nil},
      {{5, 4}, nil},
      {{5, 5}, nil},
      {{6, 2}, nil},
      {{6, 4}, nil},
      {{6, 6}, nil},
      {{7, 1}, %{colour: :black, coordinates: {7, 1}, type: :pawn}},
      {{7, 4}, %{colour: :black, coordinates: {7, 4}, type: :pawn}},
      {{7, 7}, %{colour: :black, coordinates: {7, 7}, type: :pawn}}
    ]

    pb41 = Pieces.generate_moves( %{colour: :black, coordinates: {4, 4}, type: :queen}, pid)
    |> Enum.sort()
    # |> IO.inspect(label: "4,4")
    assert pb41 == [
      {{2, 2}, %{colour: :white, coordinates: {2, 2}, type: :pawn}},
      {{2, 4}, %{colour: :white, coordinates: {2, 4}, type: :pawn}},
      {{2, 6}, %{colour: :white, coordinates: {2, 6}, type: :pawn}},
      {{3, 3}, nil},
      {{3, 4}, nil},
      {{3, 5}, nil},
      {{4, 1}, nil},
      {{4, 2}, nil},
      {{4, 3}, nil},
      {{4, 5}, nil},
      {{4, 6}, nil},
      {{4, 7}, nil},
      {{4, 8}, nil},
      {{5, 3}, nil},
      {{5, 4}, nil},
      {{5, 5}, nil},
      {{6, 2}, nil},
      {{6, 4}, nil},
      {{6, 6}, nil}
    ]


    pb71 = Pieces.generate_moves( %{colour: :black, coordinates: {8, 6}, type: :queen}, pid)
    |> Enum.sort()
    # |> IO.inspect(label: "8,6")
    assert pb71 == []

    pb61 = Pieces.generate_moves( %{colour: :white, coordinates: {8, 6}, type: :queen}, pid)
    |> Enum.sort()
    # |> IO.inspect(label: "8,6")
    assert pb61 == [
      {{7, 5}, %{colour: :black, coordinates: {7, 5}, type: :pawn}},
      {{7, 6}, %{colour: :black, coordinates: {7, 6}, type: :pawn}},
      {{7, 7}, %{colour: :black, coordinates: {7, 7}, type: :pawn}},
      {{8, 5}, %{colour: :black, coordinates: {8, 5}, type: :king}},
      {{8, 7}, %{colour: :black, coordinates: {8, 7}, type: :knight}}
    ]


    pb51 = Pieces.generate_moves( %{colour: :black, coordinates: {3, 4}, type: :queen}, pid)
    |> Enum.sort()
    # |> IO.inspect(label: "3,4 b")
    assert pb51 ==  [
      {{2, 3}, %{colour: :white, coordinates: {2, 3}, type: :pawn}},
      {{2, 4}, %{colour: :white, coordinates: {2, 4}, type: :pawn}},
      {{2, 5}, %{colour: :white, coordinates: {2, 5}, type: :pawn}},
      {{3, 1}, nil},
      {{3, 2}, nil},
      {{3, 3}, nil},
      {{3, 5}, nil},
      {{3, 6}, nil},
      {{3, 7}, nil},
      {{3, 8}, nil},
      {{4, 3}, nil},
      {{4, 4}, nil},
      {{4, 5}, nil},
      {{5, 2}, nil},
      {{5, 4}, nil},
      {{5, 6}, nil},
      {{6, 1}, nil},
      {{6, 4}, nil},
      {{6, 7}, nil}
    ]



    pb41 = Pieces.generate_moves( %{colour: :white, coordinates: {3, 4}, type: :queen}, pid)
    |> Enum.sort()
    # |> IO.inspect(label: "3,4 w")
    assert pb41 ==   [
      {{3, 1}, nil},
      {{3, 2}, nil},
      {{3, 3}, nil},
      {{3, 5}, nil},
      {{3, 6}, nil},
      {{3, 7}, nil},
      {{3, 8}, nil},
      {{4, 3}, nil},
      {{4, 4}, nil},
      {{4, 5}, nil},
      {{5, 2}, nil},
      {{5, 4}, nil},
      {{5, 6}, nil},
      {{6, 1}, nil},
      {{6, 4}, nil},
      {{6, 7}, nil},
      {{7, 4}, %{colour: :black, coordinates: {7, 4}, type: :pawn}},
      {{7, 8}, %{colour: :black, coordinates: {7, 8}, type: :pawn}}
    ]

  end

  test "verify king moves", context do
    pid = context[:pid]

    pb11 = Pieces.generate_moves( %{colour: :white, coordinates: {1, 1}, type: :king}, pid)
    |> Enum.sort()
    # |> IO.inspect(label: "1,1")
    assert pb11 == []

    pb11 = Pieces.generate_moves( %{colour: :black, coordinates: {1, 1}, type: :king}, pid)
    |> Enum.sort()
    |> IO.inspect(label: "1,1")
    assert pb11 == [{{1, 2}, %{colour: :white, coordinates: {1, 2}, type: :knight}},
                    {{2, 1}, %{colour: :white, coordinates: {2, 1}, type: :pawn}},
                    {{2, 2}, %{colour: :white, coordinates: {2, 2}, type: :pawn}}
                   ]


    pb22 = Pieces.generate_moves( %{colour: :white, coordinates: {2, 2}, type: :king}, pid)
    |> Enum.sort()
    # |> IO.inspect(label: "2,2")
    assert pb22 == [
      {{3, 1}, nil},
      {{3, 2}, nil},
      {{3, 3}, nil}
    ]


    pb22 = Pieces.generate_moves( %{colour: :black, coordinates: {2, 2}, type: :king}, pid)
    |> Enum.sort()
    # |> IO.inspect(label: "2,2")
    assert pb22 ==  [
      {{1, 1}, %{colour: :white, coordinates: {1, 1}, type: :tower}},
      {{1, 2}, %{colour: :white, coordinates: {1, 2}, type: :knight}},
      {{1, 3}, %{colour: :white, coordinates: {1, 3}, type: :bishop}},
      {{2, 1}, %{colour: :white, coordinates: {2, 1}, type: :pawn}},
      {{2, 3}, %{colour: :white, coordinates: {2, 3}, type: :pawn}},
      {{3, 1}, nil},
      {{3, 2}, nil},
      {{3, 3}, nil}
    ]




    pb44 = Pieces.generate_moves( %{colour: :white, coordinates: {4, 4}, type: :king}, pid)
    |> Enum.sort()
    # |> IO.inspect(label: "4,4")
    assert pb44 == [
      {{3, 3}, nil},
      {{3, 4}, nil},
      {{3, 5}, nil},
      {{4, 3}, nil},
      {{4, 5}, nil},
      {{5, 3}, nil},
      {{5, 4}, nil},
      {{5, 5}, nil}
    ]

    pb41 = Pieces.generate_moves( %{colour: :black, coordinates: {4, 4}, type: :king}, pid)
    |> Enum.sort()
    # |> IO.inspect(label: "4,4")
    assert pb41 == [
      {{3, 3}, nil},
      {{3, 4}, nil},
      {{3, 5}, nil},
      {{4, 3}, nil},
      {{4, 5}, nil},
      {{5, 3}, nil},
      {{5, 4}, nil},
      {{5, 5}, nil}
      ]


    pb71 = Pieces.generate_moves( %{colour: :black, coordinates: {8, 6}, type: :king}, pid)
    |> Enum.sort()
    # |> IO.inspect(label: "8,6")
    assert pb71 == []

    pb61 = Pieces.generate_moves( %{colour: :white, coordinates: {8, 6}, type: :king}, pid)
    |> Enum.sort()
    # |> IO.inspect(label: "8,6")
    assert pb61 == [
      {{7, 5}, %{colour: :black, coordinates: {7, 5}, type: :pawn}},
      {{7, 6}, %{colour: :black, coordinates: {7, 6}, type: :pawn}},
      {{7, 7}, %{colour: :black, coordinates: {7, 7}, type: :pawn}},
      {{8, 5}, %{colour: :black, coordinates: {8, 5}, type: :king}},
      {{8, 7}, %{colour: :black, coordinates: {8, 7}, type: :knight}}
    ]


    pb51 = Pieces.generate_moves( %{colour: :black, coordinates: {3, 4}, type: :king}, pid)
    |> Enum.sort()
    # |> IO.inspect(label: "3,4 b")
    assert pb51 ==  [
      {{2, 3}, %{colour: :white, coordinates: {2, 3}, type: :pawn}},
      {{2, 4}, %{colour: :white, coordinates: {2, 4}, type: :pawn}},
      {{2, 5}, %{colour: :white, coordinates: {2, 5}, type: :pawn}},
      {{3, 3}, nil},
      {{3, 5}, nil},
      {{4, 3}, nil},
      {{4, 4}, nil},
      {{4, 5}, nil}
    ]



    pb41 = Pieces.generate_moves( %{colour: :white, coordinates: {3, 4}, type: :king}, pid)
    |> Enum.sort()
    # |> IO.inspect(label: "3,4 w")
    assert pb41 ==   [
      {{3, 3}, nil},
      {{3, 5}, nil},
      {{4, 3}, nil},
      {{4, 4}, nil},
      {{4, 5}, nil}
      ]

  end



end
