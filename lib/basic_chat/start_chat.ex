defmodule BasicChat.StartChat do
  use GenServer

  def start_link(arg) when is_map(arg) do
    GenServer.start_link(__MODULE__, arg, name: __MODULE__)
  end

  ## Callbacks

  @impl true
  def init(_data) do
    {:ok, init_conversation()}
  end

  @impl true
  def handle_call(:get, _from, counter) do
    {:reply, counter, counter}
  end

  defp init_conversation do
    BasicChat.Messages.start_link(%{})
  end
end
