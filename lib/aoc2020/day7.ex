defmodule Aoc2020.Day7 do
  def part1() do
    part1(load_input())
  end

  def part1(input) do
    rules =
      input
      |> Stream.map(&parse_rule/1)
      |> Enum.into(%{})

    graph = graph(rules)

    :digraph_utils.reaching_neighbours(["shiny gold"], graph)
    |> Enum.count()
  end

  def part2() do
    part2(load_input())
  end

  def part2(input) do
    rules =
      input
      |> Stream.map(&parse_rule/1)
      |> Enum.into(%{})

    graph = graph(rules)
    count_bags(graph, "shiny gold") - 1
  end

  defp count_bags(graph, vertex) do
    graph
    |> :digraph.out_edges(vertex)
    |> Enum.reduce(1, fn e, sum ->
      {^e, _, vertex, num} = :digraph.edge(graph, e)
      sum + num * count_bags(graph, vertex)
    end)
  end

  defp parse_rule(line) do
    [container, contents] = String.split(line, " bags contain ")
    {container, contents_to_map(contents)}
  end

  defp contents_to_map("no other bags.") do
    %{}
  end

  defp contents_to_map(contents) do
    contents
    |> String.trim_trailing(".")
    |> String.split(", ")
    |> Map.new(fn content ->
      [num, type] = String.split(content, " ", parts: 2)
      type = String.trim_trailing(type, " bags")
      type = String.trim_trailing(type, " bag")
      {type, String.to_integer(num)}
    end)
  end

  defp graph(map) do
    graph = :digraph.new([:acyclic, :private])

    for {v, _} <- map, do: :digraph.add_vertex(graph, v)

    for {from, contents} <- map, {to, num} <- contents do
      :digraph.add_edge(graph, from, to, num)
    end

    graph
  end

  @doc false
  def load_input do
    path = Application.app_dir(:aoc_2020, "priv/inputs/07/bag_rules.txt")

    path
    |> File.stream!()
    |> Stream.map(&String.trim/1)
  end
end
