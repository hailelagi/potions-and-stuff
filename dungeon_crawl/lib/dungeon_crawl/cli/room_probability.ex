defmodule DungeonCrawl.CLI.Probability do
  def bias_probability(weights) do
    # Initialization
    # does the probability exist in memory?
    current_probability =
      try do
        [weights: cached_probs] = :ets.lookup(:weight_probability, :weights)
        cached_probs
      rescue
        ArgumentError -> cache(weights)
      end

    current_probability
    |> weighted_random
  end

  defp cache(weights) do
    n = Enum.count(weights)
    :ets.new(:weight_probability, [:duplicate_bag, :private, :named_table])
    :ets.insert(:weight_probability, {:weights, prepare_alias_table(weights, n)})
    [weights: cached_probs] = :ets.lookup(:weight_probability, :weights)
    cached_probs
  end

  defp prepare_alias_table(weights, n) do
    alias_table = Enum.map(1..n, fn _ -> {0, nil} end)
    prob = Enum.map(1..n, fn _ -> nil end)

    # create work lists
    scaled_weight = scale_probability(weights, n)

    small =
      scaled_weight
      |> Enum.filter(fn {_, w} -> w < 1 end)

    large =
      scaled_weight
      |> Enum.filter(fn {_, w} -> w >= 1 end)

    # recursively create table (TCO optimized)
    transform_alias(small, large, alias_table, prob)
  end

  # Base case when small and large are empty
  defp transform_alias([], [], _, prob), do: prob

  defp transform_alias(small = [], [_g = {i, _} | tail], alias_table, prob) do
    # Remove the first element from large call it g, Set prob[g] = 1
    transform_alias(
      small,
      tail,
      alias_table,
      List.replace_at(prob, i, 1)
    )
  end

  defp transform_alias([_l = {i, _} | tail], large = [], alias_table, prob) do
    # (clause will trigger due to numerical instability)
    # Remove the first element from Small, call it l
    transform_alias(
      tail,
      large,
      alias_table,
      List.replace_at(prob, i, 1)
    )
  end

  defp transform_alias(
         [{index_l, weight_l} | tail_s],
         [_g = {index_g, weight_g} | tail_l],
         alias_table,
         prob
       ) do
    # Remove the first element from small call it l
    # Remove the first element from large call it g
    # Pg := (pg + pl) - 1 (numerical stability :) )
    new_weight_g = weight_g + weight_l - 1

    # if Pg < 1 add g to small
    if new_weight_g < 1 do
      transform_alias(
        [{index_g, new_weight_g} | tail_s],
        tail_l,
        List.replace_at(alias_table, index_l, weight_g),
        List.replace_at(prob, index_l, weight_l)
      )

      # else Pg >= 1 add g to large
    else
      transform_alias(
        tail_s,
        [{index_g, new_weight_g} | tail_l],
        List.replace_at(alias_table, index_l, weight_g),
        List.replace_at(prob, index_l, weight_l)
      )
    end
  end

  # GENERATION
  defp weighted_random(aliased_table) do
    # Generate a fair random distro in a range
    # from n and call it i.
    n = Enum.count(aliased_table)
    r = Enum.random(0..1000) / 1000 * n
    # random choice P(1/3)
    # 0, 1 , 2
    i = floor(r)

    prob = aliased_table

    {:ok, odd} = Enum.fetch(prob, i)

    # partial fit
    if r - i > odd do
      # which piece of what goes where
      bias =
        prob
        |> Enum.with_index()
        |> Stream.filter(fn {p, _} -> p == 1 end)
        |> Enum.random()

      {_, i} = bias

      i
    else
      i
    end
  end

  # HELPER
  defp scale_probability(probs, n) do
    0..n
    |> Enum.zip(probs)
    |> Stream.map(fn {i, w} -> {i, w * n} end)
  end
end
