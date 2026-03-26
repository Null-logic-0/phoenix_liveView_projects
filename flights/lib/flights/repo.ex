defmodule Flights.Repo do
  use Ecto.Repo,
    otp_app: :flights,
    adapter: Ecto.Adapters.Postgres
end
