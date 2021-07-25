use Bitwise

defmodule SecretHandshake do
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    handshake = []

    handshake = if (code &&& 1) != 0, do: handshake ++ ["wink"], else: handshake
    handshake = if (code &&& 2) != 0, do: handshake ++ ["double blink"], else: handshake
    handshake = if (code &&& 4) != 0, do: handshake ++ ["close your eyes"], else: handshake
    handshake = if (code &&& 8) != 0, do: handshake ++ ["jump"], else: handshake
    handshake = if (code &&& 16) != 0, do: Enum.reverse(handshake), else: handshake

    handshake
  end
end
