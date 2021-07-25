defmodule Change do
  @doc """
    Determine the least number of coins to be given to the user such
    that the sum of the coins' value would equal the correct amount of change.
    It returns {:error, "cannot change"} if it is not possible to compute the
    right amount of coins. Otherwise returns the tuple {:ok, list_of_coins}

    ## Examples

      iex> Change.generate([5, 10, 15], 3)
      {:error, "cannot change"}

      iex> Change.generate([1, 5, 10], 18)
      {:ok, [1, 1, 1, 5, 10]}

  """

  @spec generate(list, integer) :: {:ok, list} | {:error, String.t()}
  def generate(coins, target) do
    {change, remaining} =
      coins
      |> Enum.reverse()
      |> Enum.reduce({[], target}, fn coin, {change, remaining} ->
        quotient = div(remaining, coin)
        change = List.duplicate(coin, quotient) ++ change
        remaining = remaining - coin * quotient
        {change, remaining}
      end)

    if remaining == 0 do
      {:ok, change}
    else
      {:error, "cannot change"}
    end
  end
end
