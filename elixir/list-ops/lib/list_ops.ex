defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  @spec count(list) :: non_neg_integer
  def count(l), do: count(l, 0)
  def count([], c), do: c
  def count([_ | t], c), do: count(t, c + 1)

  @spec reverse(list) :: list
  def reverse(l), do: reverse(l, [])
  def reverse([], r), do: r
  def reverse([h | t], []), do: reverse(t, [h])
  def reverse([h | t], r), do: reverse(t, [h | r])

  @spec map(list, (any -> any)) :: list
  def map([], _), do: []
  def map(l, f), do: map(l, f, [])
  def map([], _, r), do: reverse(r)
  def map([h | t], f, []), do: map(t, f, [apply(f, [h])])
  def map([h | t], f, r), do: map(t, f, [apply(f, [h]) | r])

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter([], _), do: []
  def filter(l, f), do: filter(l, f, [])
  def filter([], _, r), do: reverse(r)

  def filter([h | t], f, r) do
    if apply(f, [h]) do
      filter(t, f, [h | r])
    else
      filter(t, f, r)
    end
  end

  @type acc :: any
  @spec reduce(list, acc, (any, acc -> acc)) :: acc
  def reduce([], acc, _), do: acc
  def reduce([h | t], acc, f), do: reduce(t, apply(f, [h, acc]), f)

  @spec append(list, list) :: list
  def append([], b), do: b
  def append(a, []), do: a
  def append(a, b), do: append(a, b, [])
  def append([], [], r), do: reverse(r)
  def append([h | t], b, []), do: append(t, b, [h])
  def append([h | t], b, r), do: append(t, b, [h | r])
  def append([], [h | t], r), do: append([], t, [h | r])

  @spec concat([[any]]) :: [any]
  def concat([]), do: []
  def concat(ll), do: concat(ll, [])
  def concat([h | t], []), do: concat(t, h, [])
  def concat([], [], r), do: reverse(r)
  def concat([h | t], [], r), do: concat(t, h, r)
  def concat(ll, [h | t], r), do: concat(ll, t, [h | r])
end
