defmodule Scraper.IndexHeroes do
  @urls [
    "https://www.icy-veins.com/heroes/assassin-hero-guides",
    "https://www.icy-veins.com/heroes/warrior-hero-guides",
    "https://www.icy-veins.com/heroes/support-hero-guides",
    "https://www.icy-veins.com/heroes/specialist-hero-guides"
  ]

  def get_heroes_urls do
    Enum.map(@urls, fn(url) -> find_heroes_urls(url) end)
    |> List.flatten
  end

  def find_heroes_urls(url) do
    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}}  ->
        body
        |> Floki.find(".page_content .nav_content_block_entry_heroes_hero a")
        |> Floki.attribute("href")
        |> Enum.map(fn(hero_url) ->
          String.replace_leading(hero_url, "//", "https://")
        end)
      _ ->
        nil
    end
  end
end
