ExUnit.start

Mix.Task.run "ecto.create", ~w(-r SpeakEasyApi.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r SpeakEasyApi.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(SpeakEasyApi.Repo)

