defmodule ChessGround.Repo do
  use Ecto.Repo,
    otp_app: :chess_ground,
    adapter: Ecto.Adapters.Postgres
end
