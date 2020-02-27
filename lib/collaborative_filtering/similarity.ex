defmodule CollaborativeFiltering.Similarity do
  use Ecto.Schema
  import Ecto.Changeset

  schema "similarities" do
    field :movie_1_id, :string
    field :movie_2_id, :string
    field :score, :decimal

    timestamps()
  end

  @doc false
  def changeset(similarity, attrs) do
    similarity
    |> cast(attrs, [:movie_1_id, :movie_2_id, :score])
    |> validate_required([:movie_1_id, :movie_2_id, :score])
  end
end
