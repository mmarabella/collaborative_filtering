defmodule CollaborativeFiltering.Repo do
  use Ecto.Repo,
    otp_app: :collaborative_filtering,
    adapter: Ecto.Adapters.Postgres
end
