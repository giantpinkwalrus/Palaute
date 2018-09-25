defmodule Palaute.Repo.Migrations.CreateFeedback do
  use Ecto.Migration

  def change do
    create table(:feedback) do
      add :feedback, :string, size: 2048
      add :name, :string, null: true
      add :createdAt, :utc_datetime
    end
  end
end
