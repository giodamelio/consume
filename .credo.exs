%{
  configs: [
    %{
      name: "default",
      files: %{
        included: ["mix.exs", "lib/", "test/", "config/"]
      },
      checks: {
        {Credo.Check.Readability.ModuleDoc, false}
      }
    }
  ]
}
