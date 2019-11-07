defmodule Nas.Repo do
  use Ecto.Repo,
    otp_app: :nas,
    adapter: Ecto.Adapters.Postgres
end
