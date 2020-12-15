defmodule Aoc2020.Day15 do
  def part1() do
    part1(load_input())
  end

  def part1(input) do
    starting_numbers = input |> String.split(",", trim: true) |> Enum.map(&String.to_integer/1)
    stream(starting_numbers, 2020)
  end

  defp stream(starting_numbers, index) do
    Stream.unfold(
      %{
        turn: 0,
        start: starting_numbers,
        last_spoken: nil,
        last_spoken_at: %{}
      },
      fn
        %{start: [speak | rest]} = state ->
          state = Map.put(state, :start, rest)
          state = Map.put(state, :last_spoken, speak)
          state = update_last_spoken(state, speak)
          {speak, inc_turn(state)}

        state ->
          speak =
            case Map.fetch(state.last_spoken_at, state.last_spoken) do
              {:ok, [a, b | _]} -> a - b
              _ -> 0
            end

          state = Map.put(state, :last_spoken, speak)
          state = update_last_spoken(state, speak)
          {speak, inc_turn(state)}
      end
    )
    # |> Enum.map(&IO.inspect/1)
    |> Enum.at(index - 1)
  end

  defp inc_turn(state) do
    Map.update!(state, :turn, &(&1 + 1))
  end

  defp update_last_spoken(state, speak) do
    Map.update!(state, :last_spoken_at, fn map ->
      Map.update(map, speak, [state.turn], fn [last | _] ->
        [state.turn, last]
      end)
    end)
  end

  def part2() do
    part2(load_input())
  end

  def part2(input) do
    starting_numbers = input |> String.split(",", trim: true) |> Enum.map(&String.to_integer/1)
    stream(starting_numbers, 30_000_000)
  end

  @doc false
  def load_input do
    "9,19,1,6,0,5,4"
  end
end
