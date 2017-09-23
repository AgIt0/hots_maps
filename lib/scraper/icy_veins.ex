defmodule Scraper.IcyVeins do
  alias Scraper.{IndexHeroes, HeroPage, HeroConverter}
  def run do
    IndexHeroes.get_heroes_urls
    |> Enum.map(fn(url) -> HeroPage.get_hero_maps(url) end)
    |> Enum.map(fn(hero_map) -> HeroConverter.convert(hero_map) end)
    |> Enum.reduce(fn(hero1, hero2) ->
      Map.merge(hero1, hero2, fn(_k, v1, v2) ->
        Map.merge(v1, v2, fn(_k1, c1, c2) ->
          [c1, c2] |> List.flatten
        end)
      end)
    end)
  end
end
