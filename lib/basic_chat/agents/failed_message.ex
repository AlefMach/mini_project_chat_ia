defmodule BasicChat.FailedMessage do
  use Agent

  @spec start_link(any) :: {:error, any} | {:ok, pid}
  def start_link(initial_value) do
    Agent.start_link(fn -> initial_value end, name: __MODULE__)
  end

  @spec last_message :: any
  def last_message do
    Agent.get(__MODULE__, & &1)
  end

  @spec update_message(any) :: :ok
  def update_message(message) do
    Agent.update(__MODULE__, &(&1 = message))
  end
end
