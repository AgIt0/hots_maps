defmodule Scraper.HeroConverter do
  # %{"Alarak" => %{
  #   average_maps: ["Battlefield of Eternity", "Blackheart's Bay",
  #                 "Cursed Hollow", "Dragon Shire", "Garden of Terror", "Hanamura",
  #                 "Sky Temple", "Tomb of the Spider Queen", "Warhead Junction"],
  #   strong_maps: ["Braxis Holdout", "Towers of Doom"],
  #   weak_maps: ["Haunted Mines", "Infernal Shrines"]}
  # }
  def convert(hero_map) do
    hero_name = get_hero_name(hero_map)
    [
      convert_strong_maps(hero_map, hero_name),
      convert_average_maps(hero_map, hero_name),
      convert_weak_maps(hero_map, hero_name)
    ]
    |> List.flatten
    |> Enum.reduce(fn(map, acc) -> Map.merge(map, acc) end)
  end

  defp get_hero_name(hero_map) do
    hero_map
    |> Map.keys
    |> Enum.at(0)
  end

  defp convert_average_maps(hero_map, hero_name) do
    hero_map
    |> Map.get(hero_name)
    |> Map.get(:average_maps)
    |> Enum.map(fn(map) -> %{map => %{average_heroes: [hero_name]}}end)
  end

  defp convert_strong_maps(hero_map, hero_name) do
    hero_map
    |> Map.get(hero_name)
    |> Map.get(:strong_maps)
    |> Enum.map(fn(map) -> %{map => %{strong_heroes: [hero_name]}}end)
  end

  defp convert_weak_maps(hero_map, hero_name) do
    hero_map
    |> Map.get(hero_name)
    |> Map.get(:weak_maps)
    |> Enum.map(fn(map) -> %{map => %{weak_heroes: [hero_name]}}end)
  end
end
