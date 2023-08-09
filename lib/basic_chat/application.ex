defmodule BasicChat.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  alias BasicChat.StartChat
  alias BasicChat.FailedMessage


  @impl true
  def start(_type, _args) do
    children = [
      %{
        id: StartChat,
        start: {StartChat, :start_link, [%{}]}
      },
      %{
        id: FailedMessage,
        start: {FailedMessage, :start_link, [%{"first_failed_response" => "Desculpe, não consegui te entender, tem certeza que você me passou uma string?"}]}
      }
    ]

    opts = [strategy: :one_for_one, name: BasicChat.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
