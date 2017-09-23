defmodule HotsMapsWeb.PageView do
  use HotsMapsWeb, :view

  def maps do
    MapsCache.Cache.fetch
  end
end
