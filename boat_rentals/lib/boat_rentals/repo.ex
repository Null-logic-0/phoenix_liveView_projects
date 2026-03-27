defmodule BoatRentals.Repo do
  use Ecto.Repo,
    otp_app: :boat_rentals,
    adapter: Ecto.Adapters.Postgres
end
