defmodule PorchLight.Repo do
  use Ecto.Repo,
    otp_app: :porch_light,
    adapter: Ecto.Adapters.Postgres
end
