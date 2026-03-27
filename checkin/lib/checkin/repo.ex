defmodule Checkin.Repo do
  use Ecto.Repo,
    otp_app: :checkin,
    adapter: Ecto.Adapters.Postgres
end
