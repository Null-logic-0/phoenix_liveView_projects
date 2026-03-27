defmodule LiveNav.Servers.Server do
  use Ecto.Schema
  import Ecto.Changeset

  schema "servers" do
    field :name, :string
    field :status, :string
    field :deploy_count, :integer
    field :size, :float
    field :framework, :string
    field :last_commit_message, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(server, attrs) do
    server
    |> cast(attrs, [:name, :status, :deploy_count, :size, :framework, :last_commit_message])
    |> validate_required([:name, :status, :deploy_count, :size, :framework, :last_commit_message])
  end
end
