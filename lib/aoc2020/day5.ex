defmodule Aoc2020.Day5.Seat do
  @opaque t :: %__MODULE__{
            binary: String.t(),
            row: nil | non_neg_integer(),
            seat: nil | non_neg_integer(),
            id: nil | non_neg_integer()
          }

  defstruct binary: nil, row: nil, seat: nil, id: nil

  defmacro sigil_b(binary, _) do
    quote do
      ~s"#{unquote(binary)}"
      |> unquote(__MODULE__).parse()
    end
  end

  def parse(<<row_code::binary-size(7), seat_code::binary-size(3)>> = binary) do
    [row] =
      for <<char::binary-size(1) <- row_code>>, reduce: 0..127 do
        acc -> binary_search(char, acc)
      end
      |> Enum.to_list()

    [seat] =
      for <<char::binary-size(1) <- seat_code>>, reduce: 0..7 do
        acc -> binary_search(char, acc)
      end
      |> Enum.to_list()

    %__MODULE__{binary: binary, row: row, seat: seat, id: row * 8 + seat}
  end

  defp binary_search(lower, low..high) when lower in ["F", "L"] do
    low..div(high + low, 2)
  end

  defp binary_search(upper, low..high) when upper in ["B", "R"] do
    div(high + low + 1, 2)..high
  end

  def info(%__MODULE__{} = seat) do
    seat
    |> Map.from_struct()
    |> Map.take([:row, :seat, :id])
  end

  defimpl Inspect do
    def inspect(seat, _opts) do
      Inspect.Algebra.concat(["~b\"", Inspect.Algebra.string(seat.binary), "\""])
    end
  end
end

defmodule Aoc2020.Day5 do
  import Aoc2020.Day5.Seat

  def part1() do
    part1(load_input())
  end

  def part1(input) do
    input
    |> Stream.map(fn code ->
      Map.fetch!(info(~b"#{code}"), :id)
    end)
    |> Enum.max()
  end

  def part2() do
    part2(load_input())
  end

  def part2(input) do
    ids =
      input
      |> Stream.map(fn code ->
        Map.fetch!(info(~b"#{code}"), :id)
      end)

    min = Enum.min(ids)
    max = Enum.max(ids)

    min..max
    |> Stream.chunk_every(3, 1, :discard)
    |> Stream.map(fn [id1, id2, id3] ->
      [
        if(id1 in ids, do: id1),
        if(id2 in ids, do: id2),
        if(id3 in ids, do: id3)
      ]
    end)
    |> Enum.find_value(fn
      [id1, nil, id2] when is_integer(id1) and is_integer(id2) -> id1 + 1
      _ -> false
    end)
  end

  @doc false
  def load_input do
    path = Application.app_dir(:aoc_2020, "priv/inputs/05/boarding_passes.txt")

    path
    |> File.stream!()
    |> Stream.map(&String.trim/1)
  end
end
