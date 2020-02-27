defmodule CollaborativeFiltering.Repo.Migrations.CreateSimilarities do
  use Ecto.Migration

  def change do
    create table(:similarities) do
      add :movie_1_id, :string
      add :movie_2_id, :string
      add :score, :decimal

      timestamps()
    end

  end
end
