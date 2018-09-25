defmodule Palaute.Repo.Migrations.ModifyFeedback do
  use Ecto.Migration

  def change do
    alter table("feedback") do
      remove :createdAt

      timestamps()
    end
  end
end
