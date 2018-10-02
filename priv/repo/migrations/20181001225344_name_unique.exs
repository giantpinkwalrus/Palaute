defmodule Palaute.Repo.Migrations.NameUnique do
  use Ecto.Migration

  def change do
    alter table("user") do
      modify :name, :string, unique: true
    end
  end
end
