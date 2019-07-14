defmodule Anarchess.Repo do
  use Ecto.Repo,
    otp_app: :anarchess,
    adapter: Ecto.Adapters.Postgres
end
