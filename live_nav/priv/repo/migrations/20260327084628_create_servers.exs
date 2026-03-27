defmodule LiveNav.Repo.Migrations.CreateServers do
  use Ecto.Migration

  def change do
    create table(:servers) do
      add(:name, :string)
      add(:status, :string, default: "down")
      add(:deploy_count, :integer, default: 0)
      add(:size, :float)
      add(:framework, :string)
      add(:last_commit_message, :string)

      timestamps(type: :utc_datetime)
    end
  end
end
