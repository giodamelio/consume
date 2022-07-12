# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Consume.Repo.insert!(%Consume.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
Consume.Repo.insert!(%Consume.Feeds.Feed{
  enabled: false,
  fetch_after: ~U[2022-07-12 02:16:49Z],
  fetch_frequency_seconds: 10,
  fetcher: :http_get,
  inserted_at: ~N[2022-07-10 23:55:39],
  name: "NASA Breaking News",
  parser: :rss2_0,
  updated_at: ~N[2022-07-12 02:16:39],
  url: "https://www.nasa.gov/rss/dyn/breaking_news.rss"
})
