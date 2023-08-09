defmodule BasicChat.Data do
  @moduledoc """
  Module responsable for guard data to response
  """

  @doc """
  provides the list key to response
  """
  def list_keys do
    [
      "oie",
      "oi",
      "olá",
      "koe",
      "tudo bem?",
      "como está?",
      "Como você está?",
      "estou bem",
      "bem",
      "mal",
      "estou mal",
      "ainda bem",
      "fez",
      "fui",
      "você",
      "bom dia!",
      "boa tarde!",
      "boa noite!",
      "você está",
      "estive",
      "que legal",
      "que ruim",
      "não era isso",
      "não",
      "sim",
      "por que?",
      "porque",
      "fala",
      "e você?",
      "como vai você?",
      "tchau",
      "adeus",
      "até mais"
    ]
  end

  @doc """
  provides the message about key
  """
  def match_response(key) do
    match(key)
  end

  @doc """
  response default for key not found
  """
  def not_found_match_response,
    do: ["Não entendi o que você quis dizer, pode tentar outra frase?"]

  @spec params_wrong :: [<<_::64, _::_*8>>, ...]
  def params_wrong,
    do: [
      "Ainda não consegui te entender, poderia tentar novamente?",
      "Em vez de #, poderia tentar parâmetros como: 'Olá', 'oi', 'como vai?'",
      "Vamos tentar mais uma vez? ainda não consigo te entender"
    ]

  @doc """
  responses default for message repeat from user
  """
  def repeat_phrases, do: ["novamente!", "mais uma vez!"]

  defp match(key) when key in ["oie", "oi", "olá", "koe"], do: ["Olá", "Oi"]

  defp match(key)
       when key in ["tudo bem?", "como está?", "como vai você?", "Como você está?", "você está"],
       do: ["Estou bem, como posso ajudar?", "Bem, obrigado!, como posso ser útil?"]

  defp match(key) when key in ["estou bem", "estou mal", "fala"],
    do: ["Conte-me mais sobre isso!", "O que aconteceu para você estar assim?"]

  defp match(key) when key in ["que ruim", "mal"],
    do: ["Vai melhorar, acredite!", "Vai ficar tudo bem!"]

  defp match(key) when key in ["bom dia!", "boa tarde!", "boa noite!"], do: [String.trim(key)]

  defp match(key) when key in ["não era isso", "não"],
    do: ["Me desculpe!, vamos tentar novamente?", "Desculpa pelo engano, pode dizer novamente?"]

  defp match(key) when key in ["sim", "que legal"], do: ["Fico feliz por isso!", "Que bom!"]

  defp match(key) when key in ["tchau", "adeus", "até mais"],
    do: ["Tchau, até a próxima!", "Obrigado pelo papo! Até mais"]

  defp match(_key), do: []
end
