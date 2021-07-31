defmodule BankAccount do
  use GenServer

  @moduledoc """
  A bank account that supports access from multiple processes.
  """

  @typedoc """
  An account handle.
  """
  @opaque account :: pid

  @doc """
  Open the bank. Makes the account available.
  """
  @spec open_bank() :: account
  def open_bank() do
    state = %{balance: 0, active: true}
    {:ok, pid} = GenServer.start(__MODULE__, state)
    pid
  end

  def init(initial_state) do
    {:ok, initial_state}
  end

  @doc """
  Close the bank. Makes the account unavailable.
  """
  @spec close_bank(account) :: none
  def close_bank(account) do
    GenServer.cast(account, :close_bank)
  end

  @doc """
  Get the account's balance.
  """
  @spec balance(account) :: integer
  def balance(account) do
    GenServer.call(account, :balance)
  end

  @doc """
  Update the account's balance by adding the given amount which may be negative.
  """
  @spec update(account, integer) :: any
  def update(account, amount) do
    GenServer.call(account, {:add, amount})
  end

  def handle_cast(:close_bank, _) do
    {:noreply, %{balance: 0, active: false}}
  end

  def handle_call(_, _from, %{balance: balance, active: false}) do
    {:reply, {:error, :account_closed}, %{balance: balance, active: false}}
  end

  def handle_call(:balance, _from, state) do
    {:reply, state[:balance], state}
  end

  def handle_call({:add, amount}, _from, state) do
    balance = state[:balance] + amount
    {:reply, balance, %{balance: balance, active: true}}
  end
end
