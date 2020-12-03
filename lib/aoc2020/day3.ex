defmodule Aoc2020.Day3 do
  def part1() do
    part1(load_input())
  end

  def part1(input) do
    start = {0, 0}
    trajectory = {3, 1}

    path = path(input, start, trajectory)
    Enum.count(path, fn type -> type == :tree end)
  end

  def part2() do
    part2(load_input())
  end

  def part2(input) do
    start = {0, 0}
    trajectories = [{1, 1}, {3, 1}, {5, 1}, {7, 1}, {1, 2}]

    trajectories
    |> Enum.map(fn trajectory ->
      path = path(input, start, trajectory)
      Enum.count(path, fn type -> type == :tree end)
    end)
    |> Enum.reduce(&Kernel.*/2)
  end

  defp path(map, start, trajectory) do
    Stream.unfold(start, fn coords ->
      coords = move(coords, trajectory)

      case type_at_coordinate(map, coords) do
        {:ok, :end} -> nil
        {:ok, type} -> {type, coords}
      end
    end)
  end

  defp move({la, lb}, {ra, rb}), do: {la + ra, lb + rb}

  defp type_at_coordinate(%{map: _map, size: {_max_x, max_y}}, {_x, y}) when y >= max_y,
    do: {:ok, :end}

  defp type_at_coordinate(%{map: map, size: {max_x, _max_y}}, {x, y}) do
    x = rem(x, max_x)

    Map.fetch(map, {x, y})
  end

  @doc false
  def load_input do
    path = Application.app_dir(:aoc_2020, "priv/inputs/03/map.txt")

    [line | _] =
      lines =
      path
      |> File.stream!()
      |> Stream.map(fn line -> line |> String.trim() |> String.codepoints() end)
      |> Enum.to_list()

    map =
      for {line, y} <- Enum.with_index(lines),
          {type, x} <- Enum.with_index(line),
          into: %{},
          do: {{x, y}, convert_type(type)}

    %{map: map, size: {Enum.count(line), Enum.count(lines)}}
  end

  defp convert_type("."), do: :space
  defp convert_type("#"), do: :tree
end
