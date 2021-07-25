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
    if target < 0 do
      {:error, "cannot change"}
    else
      generate(Enum.reverse(coins), target, [])
    end
  end

  defp generate(_, 0, change), do: {:ok, change}
  defp generate([], _, _), do: {:error, "cannot change"}

  defp generate(coins, remaining, change) do
    {coin, coins} = List.pop_at(coins, 0)

    # get result if current coin not included
    {status_1, result_1} = generate(coins, remaining, change)

    quotient = div(remaining, coin)
    change = List.duplicate(coin, quotient) ++ change
    remaining = remaining - coin * quotient
    # get result if current coin included
    {status_2, result_2} = generate(coins, remaining, change)

    cond do
      status_1 == :error -> {status_2, result_2}
      status_2 == :error -> {status_1, result_1}
      length(result_1) < length(result_2) -> {status_1, result_1}
      true -> {status_2, result_2}
    end
  end
end
