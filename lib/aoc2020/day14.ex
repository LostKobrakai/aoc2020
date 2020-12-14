defmodule Aoc2020.Day14 do
  defmodule Program do
    defstruct memory: %{},
              bitmask: %{
                mask: 0b000000000000000000000000000000000000,
                value: 0b000000000000000000000000000000000000
              }
  end

  defmodule ProgramV2 do
    defstruct memory: %{},
              bitmask: %{
                mask: 0b000000000000000000000000000000000000,
                values: [0b000000000000000000000000000000000000]
              }
  end

  import Bitwise

  def part1() do
    part1(load_input())
  end

  def part1(input) do
    program =
      Enum.reduce(input, %Program{}, fn
        <<"mask = ", mask::binary>>, program ->
          struct!(program, bitmask: parse_mask(mask))

        <<"mem", memory::binary>>, program ->
          [location, value] = String.split(memory, " = ")

          location =
            location
            |> String.trim_leading("[")
            |> String.trim_trailing("]")
            |> String.to_integer()

          value = String.to_integer(value)
          masked_value = (value &&& program.bitmask.mask) ||| program.bitmask.value
          struct!(program, memory: Map.put(program.memory, location, masked_value))
      end)

    program.memory
    |> Map.values()
    |> Enum.sum()
  end

  defp start_mask do
    %{
      mask: 0b000000000000000000000000000000000000,
      value: 0b000000000000000000000000000000000000
    }
  end

  defp parse_mask(binary, acc \\ start_mask())
  defp parse_mask("", acc), do: acc

  defp parse_mask(<<"X", rest::binary>>, acc) do
    parse_mask(rest, set_mask_values(acc, {0b1, 0b0}))
  end

  defp parse_mask(<<"1", rest::binary>>, acc) do
    parse_mask(rest, set_mask_values(acc, {0b0, 0b1}))
  end

  defp parse_mask(<<"0", rest::binary>>, acc) do
    parse_mask(rest, set_mask_values(acc, {0b0, 0b0}))
  end

  defp set_mask_values(acc, {m, v}) do
    acc
    |> Map.update!(:mask, &set_mask_value(&1, m))
    |> Map.update!(:value, &set_mask_value(&1, v))
  end

  def part2() do
    part2(load_input())
  end

  def part2(input) do
    program =
      Enum.reduce(input, %Program{}, fn
        <<"mask = ", mask::binary>>, program ->
          struct!(program, bitmask: parse_mask_v2(mask))

        <<"mem", memory::binary>>, program ->
          [location, value] = String.split(memory, " = ")

          location =
            location
            |> String.trim_leading("[")
            |> String.trim_trailing("]")
            |> String.to_integer()

          value = String.to_integer(value)

          memory =
            for mask <- program.bitmask.values, reduce: program.memory do
              memory ->
                mirror = (location &&& program.bitmask.mask) ||| mask
                Map.put(memory, mirror, value)
            end

          struct!(program, memory: memory)
      end)

    program.memory
    |> Map.values()
    |> Enum.sum()
  end

  defp start_mask_v2 do
    %{
      mask: 0b000000000000000000000000000000000000,
      values: [0b000000000000000000000000000000000000]
    }
  end

  defp parse_mask_v2(binary, acc \\ start_mask_v2())
  defp parse_mask_v2("", acc), do: acc

  defp parse_mask_v2(<<"1", rest::binary>>, acc) do
    acc = Map.update!(acc, :mask, &set_mask_value(&1, 0b0))
    parse_mask_v2(rest, set_mask_values_v2(acc, 0b1))
  end

  defp parse_mask_v2(<<"0", rest::binary>>, acc) do
    acc = Map.update!(acc, :mask, &set_mask_value(&1, 0b1))
    parse_mask_v2(rest, set_mask_values_v2(acc, 0b0))
  end

  defp parse_mask_v2(<<"X", rest::binary>>, acc) do
    acc = Map.update!(acc, :mask, &set_mask_value(&1, 0b0))
    parse_mask_v2(rest, set_mask_values_v2(acc, [0b1, 0b0]))
  end

  defp set_mask_values_v2(acc, list_or_value) do
    Map.update!(acc, :values, fn list ->
      for current <- list, bit <- List.wrap(list_or_value) do
        set_mask_value(current, bit)
      end
    end)
  end

  defp set_mask_value(current, v) do
    current <<< 1 ||| v
  end

  @doc false
  def load_input do
    path = Application.app_dir(:aoc_2020, "priv/inputs/14/instructions.txt")

    File.stream!(path)
    |> Stream.map(&String.trim/1)
  end
end
