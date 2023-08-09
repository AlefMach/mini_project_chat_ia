defmodule BasicChat.Messages do
  use Agent

  def start_link(initial_value) do
    Agent.start_link(fn -> initial_value end, name: __MODULE__)
  end

  def last_message do
    Agent.get(__MODULE__, & &1)
  end

  def update_conversation(params) do
    Agent.update(__MODULE__, &(&1 = params))
  end
end
