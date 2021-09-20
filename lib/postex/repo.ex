defmodule Postex.Repo do
  use Ecto.Repo,
    otp_app: :postex,
    adapter: Ecto.Adapters.Postgres
end
