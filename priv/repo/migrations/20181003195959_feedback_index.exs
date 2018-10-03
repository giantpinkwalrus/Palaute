defmodule Palaute.Repo.Migrations.FeedbackIndex do
  use Ecto.Migration

  def change do
    create index("feedback", [:id, :name, :inserted_at])
  end
end
