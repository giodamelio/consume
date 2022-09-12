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

Consume.Repo.insert!(%Consume.Fetcher.Feed{
  name: "NASA Breaking News",
  uri: "https://www.nasa.gov/rss/dyn/breaking_news.rss",
  fetcher: :rss2_0,
  fetch_after: DateTime.now!("Etc/UTC"),
  fetch_interval_seconds: 10
})

Consume.Repo.insert!(%Consume.Fetcher.Feed{
  name: "NASA Image of the Day",
  uri: "https://www.nasa.gov/rss/dyn/lg_image_of_the_day.rss",
  fetcher: :rss2_0,
  fetch_after: DateTime.now!("Etc/UTC"),
  fetch_interval_seconds: 10
})

Consume.Repo.insert!(%Consume.Fetcher.Feed{
  name: "NASA Space Station News",
  uri: "https://www.nasa.gov/rss/dyn/shuttle_station.rss",
  fetcher: :rss2_0,
  fetch_after: DateTime.now!("Etc/UTC"),
  fetch_interval_seconds: 10
})
