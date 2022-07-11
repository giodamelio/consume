ExUnit.configure(exclude: [slow: true])
ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(Consume.Repo, :manual)
