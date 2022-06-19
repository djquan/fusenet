defmodule Fusenet.Repo do
  use Ecto.Repo,
    otp_app: :fusenet,
    adapter: Ecto.Adapters.Postgres
end
