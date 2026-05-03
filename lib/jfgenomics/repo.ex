defmodule Jfgenomics.Repo do
  use Ecto.Repo,
    otp_app: :jfgenomics,
    adapter: Ecto.Adapters.Postgres
end
