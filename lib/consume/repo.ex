defmodule Consume.Repo do
  use Ecto.Repo,
    otp_app: :consume,
    adapter: Ecto.Adapters.Postgres
end
