defmodule Aoc2020.Day17 do
  defmodule Game do
    defstruct active: %{}

    def new(input) do
      active =
        for {line, y} <- Enum.with_index(String.split(input, "\n", trim: true)),
            {char, x} <- Enum.with_index(String.split(line, "", trim: true)),
            char == "#",
            into: %{},
            do: {{x, y, 0}, true}

      start = %__MODULE__{active: active}

      Stream.unfold(start, &tick/1)
    end

    def state_at(%__MODULE__{active: active}, print_z) do
      {{{min_x, max_x}, {min_y, max_y}}, active} =
        for {{x, y, z}, true} <- active, reduce: {{nil, nil}, %{}} do
          {minmax, active} ->
            minmax =
              case minmax do
                {nil, nil} ->
                  {
                    {x, x},
                    {y, y}
                  }

                {{min_x, max_x}, {min_y, max_y}} ->
                  {
                    {min(min_x, x), max(max_x, x)},
                    {min(min_y, y), max(max_y, y)}
                  }
              end

            active = if z == print_z, do: Map.put(active, {x, y}, true), else: active
            {minmax, active}
        end

      Enum.map_join(min_y..max_y, "\n", fn y ->
        Enum.map_join(min_x..max_x, "", fn x ->
          if Map.has_key?(active, {x, y}), do: "#", else: "."
        end)
      end)
    end

    defp tick(%__MODULE__{active: active}) do
      start = Map.new(active, fn {c, _} -> {c, 0} end)

      affected_coordinates =
        for {{source_x, source_y, source_z}, _} <- active,
            x <- -1..1,
            y <- -1..1,
            z <- -1..1,
            {0, 0, 0} != {x, y, z},
            reduce: start do
          acc ->
            affected = {source_x + x, source_y + y, source_z + z}
            Map.update(acc, affected, 1, &(&1 + 1))
        end

      active =
        Enum.reduce(affected_coordinates, active, fn {coords, num}, acc ->
          case {Map.has_key?(active, coords), num} do
            {true, num} when num != 2 and num != 3 -> Map.delete(acc, coords)
            {false, 3} -> Map.put(acc, coords, true)
            _ -> acc
          end
        end)

      game = %__MODULE__{active: active}

      {game, game}
    end
  end

  defmodule Game4D do
    defstruct active: %{}

    def new(input) do
      active =
        for {line, y} <- Enum.with_index(String.split(input, "\n", trim: true)),
            {char, x} <- Enum.with_index(String.split(line, "", trim: true)),
            char == "#",
            into: %{},
            do: {{x, y, 0, 0}, true}

      start = %__MODULE__{active: active}

      Stream.unfold(start, &tick/1)
    end

    def state_at(%__MODULE__{active: active}, print_z, print_w) do
      {{{min_x, max_x}, {min_y, max_y}}, active} =
        for {{x, y, z, w}, true} <- active, reduce: {{nil, nil}, %{}} do
          {minmax, active} ->
            minmax =
              case minmax do
                {nil, nil} ->
                  {
                    {x, x},
                    {y, y}
                  }

                {{min_x, max_x}, {min_y, max_y}} ->
                  {
                    {min(min_x, x), max(max_x, x)},
                    {min(min_y, y), max(max_y, y)}
                  }
              end

            active =
              if z == print_z and w == print_w, do: Map.put(active, {x, y}, true), else: active

            {minmax, active}
        end

      Enum.map_join(min_y..max_y, "\n", fn y ->
        Enum.map_join(min_x..max_x, "", fn x ->
          if Map.has_key?(active, {x, y}), do: "#", else: "."
        end)
      end)
    end

    defp tick(%__MODULE__{active: active}) do
      start = Map.new(active, fn {c, _} -> {c, 0} end)

      affected_coordinates =
        for {{source_x, source_y, source_z, source_w}, _} <- active,
            x <- -1..1,
            y <- -1..1,
            z <- -1..1,
            w <- -1..1,
            {0, 0, 0, 0} != {x, y, z, w},
            reduce: start do
          acc ->
            affected = {source_x + x, source_y + y, source_z + z, source_w + w}
            Map.update(acc, affected, 1, &(&1 + 1))
        end

      active =
        Enum.reduce(affected_coordinates, active, fn {coords, num}, acc ->
          case {Map.has_key?(active, coords), num} do
            {true, num} when num != 2 and num != 3 -> Map.delete(acc, coords)
            {false, 3} -> Map.put(acc, coords, true)
            _ -> acc
          end
        end)

      game = %__MODULE__{active: active}

      {game, game}
    end
  end

  def part1() do
    part1(load_input())
  end

  def part1(input) do
    Game.new(input)
    |> Enum.at(5)
    |> Map.get(:active)
    |> Enum.count()
  end

  def part2() do
    part2(load_input())
  end

  def part2(input) do
    Game4D.new(input)
    |> Enum.at(5)
    |> Map.get(:active)
    |> Enum.count()
  end

  @doc false
  def load_input do
    path = Application.app_dir(:aoc_2020, "priv/inputs/17/state.txt")

    File.read!(path)
  end
end
