defmodule Scraper.IcyVeins do
  alias Scraper.{IndexHeroes, HeroPage, HeroConverter}
  def run do
    IndexHeroes.get_heroes_urls
    |> Enum.map(fn(url) -> HeroPage.get_hero_maps(url) end)
    |> Enum.map(fn(hero_map) -> HeroConverter.convert(hero_map) end)
  end
end
