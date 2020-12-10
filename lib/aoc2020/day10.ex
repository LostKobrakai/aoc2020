defmodule Aoc2020.Day10 do
  def part1() do
    part1(load_input())
  end

  def part1(input) do
    input
    |> Enum.sort()
    |> Stream.chunk_while(0, &chunk_fun/2, &after_fun/1)
    |> Enum.frequencies()
    |> case do
      %{1 => a, 3 => b} -> a * b
      _ -> 0
    end
  end

  defp chunk_fun(element, acc) do
    {:cont, element - acc, element}
  end

  defp after_fun(acc), do: {:cont, 3, acc}

  def part2() do
    part2(load_input())
  end

  def part2(input) do
    ratings =
      input
      |> Enum.sort()
      |> List.insert_at(0, 0)
      |> Stream.chunk_while(0, &chunk_fun_2/2, &after_fun_2/1)
      |> Enum.to_list()

    set = MapSet.new(ratings)

    graph = :digraph.new([:acyclic, :private])

    for rating <- ratings, do: :digraph.add_vertex(graph, rating)

    for rating <- ratings, num <- [1, 2, 3], to = num + rating, to in set do
      :digraph.add_edge(graph, rating, to)
    end

    [last] =
      graph
      |> :digraph.vertices()
      |> Enum.filter(fn v ->
        :digraph.out_degree(graph, v) == 0
      end)

    annotate_edges(graph, last)
    num_at(graph, 0)
  end

  defp chunk_fun_2(element, _acc) do
    {:cont, element, element}
  end

  defp after_fun_2(acc), do: {:cont, acc + 3, acc}

  defp annotate_edges(graph, v, done \\ []) do
    num = num_at(graph, v)

    graph
    |> :digraph.in_edges(v)
    |> Enum.map(fn e ->
      {e, x, y, _} = :digraph.edge(graph, e)
      :digraph.add_edge(graph, e, x, y, num)
    end)

    done = [v | done]

    graph
    |> :digraph.in_neighbours(v)
    |> Enum.reduce(done, fn v, done ->
      if v not in done do
        annotate_edges(graph, v, done)
      else
        done
      end
    end)
  end

  def num_at(graph, v) do
    case :digraph.out_edges(graph, v) do
      [] ->
        1

      edges ->
        edges
        |> Enum.map(fn e ->
          {_, _, _, num} = :digraph.edge(graph, e)
          num
        end)
        |> Enum.sum()
    end
  end

  @doc false
  def load_input do
    path = Application.app_dir(:aoc_2020, "priv/inputs/10/adapter_ratings.txt")

    path
    |> File.stream!()
    |> Stream.map(&String.trim/1)
    |> Stream.map(&String.to_integer/1)
  end
end
