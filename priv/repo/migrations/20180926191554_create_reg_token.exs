defmodule Palaute.Repo.Migrations.CreateRegToken do
  use Ecto.Migration

  def change do
    create table(:reg_token, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :used, :boolean, default: false, null: false

      timestamps()
    end

  end
end
