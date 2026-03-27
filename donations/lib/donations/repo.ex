defmodule Donations.Repo do
  use Ecto.Repo,
    otp_app: :donations,
    adapter: Ecto.Adapters.Postgres
end
