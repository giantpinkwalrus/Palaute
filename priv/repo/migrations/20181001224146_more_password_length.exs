defmodule Palaute.Repo.Migrations.MorePasswordLength do
  use Ecto.Migration

  def change do
    alter table("user") do
      modify :password, :string, size: 2048
    end
  end
end
