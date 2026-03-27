defmodule LiveNav.Repo do
  use Ecto.Repo,
    otp_app: :live_nav,
    adapter: Ecto.Adapters.Postgres
end
