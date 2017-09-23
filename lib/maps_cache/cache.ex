defmodule MapsCache.Cache do
  use GenServer

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, [
      {:ets_table_name, :map_cache_table},
      {:log_limit, 1_000_000}
    ], opts)
  end

  def fetch do
    case get(:icy_veins) do
      {:not_found} -> set(:icy_veins, Scraper.IcyVeins.run)
      {:found, result} -> result
    end
  end

  defp get(key) do
    case GenServer.call(__MODULE__, {:get, key}) do
      [] -> {:not_found}
      [{_key, result}] -> {:found, result}
    end
  end

  defp set(key, value) do
    GenServer.call(__MODULE__, {:set, key, value})
  end

  # GenServer callbacks
  def init(args) do
    [{:ets_table_name, ets_table_name}, {:log_limit, log_limit}] = args

    :ets.new(ets_table_name, [:named_table, :set, :private])

    {:ok, %{log_limit: log_limit, ets_table_name: ets_table_name}}
  end

  def handle_call({:get, key}, _from, state) do
    %{ets_table_name: ets_table_name} = state
    result = :ets.lookup(ets_table_name, key)
    {:reply, result, state}
  end

  def handle_call({:set, key, value}, _from, state) do
    %{ets_table_name: ets_table_name} = state
    true = :ets.insert(ets_table_name, {key, value})
    {:reply, value, state}
  end
end
