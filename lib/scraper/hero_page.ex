defmodule Scraper.HeroPage do
  def get_hero_maps(url) do
    %HTTPoison.Response{status_code: 200, body: body} =
      HTTPoison.get!(url)

    IO.puts("Fetching maps for #{get_hero_name(body)}")
    %{
      get_hero_name(body) => %{
        strong_maps: get_strong_maps(body),
        average_maps: get_average_maps(body),
        weak_maps: get_weak_maps(body)
      }
    }
  end

  defp get_hero_name(html) do
    html
      |> Floki.find(".page_breadcrumbs_item")
      |> Enum.at(-1)
      |> Floki.text
  end

  defp get_strong_maps(html) do
    html
      |> Floki.find(".heroes_tldr_maps_stronger img")
      |> Floki.attribute("title")
  end

  defp get_average_maps(html) do
    html
      |> Floki.find(".heroes_tldr_maps_average img")
      |> Floki.attribute("title")
  end

  defp get_weak_maps(html) do
    html
      |> Floki.find(".heroes_tldr_maps_weaker img")
      |> Floki.attribute("title")
  end
end
