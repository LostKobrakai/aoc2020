defmodule Aoc2020.Day9Test do
  use ExUnit.Case, async: true

  describe "part 1" do
    test "example 1" do
      stream =
        """
        35
        20
        15
        25
        47
        40
        62
        55
        65
        95
        102
        117
        150
        182
        127
        219
        299
        277
        309
        576
        """
        |> String.split("\n", trim: true)
        |> Stream.map(&String.to_integer/1)

      assert 127 = Aoc2020.Day9.part1(stream, 5)
    end
  end

  describe "part 2" do
    test "example 1" do
      stream =
        """
        35
        20
        15
        25
        47
        40
        62
        55
        65
        95
        102
        117
        150
        182
        127
        219
        299
        277
        309
        576
        """
        |> String.split("\n", trim: true)
        |> Stream.map(&String.to_integer/1)

      search = Aoc2020.Day9.part1(stream, 5)

      assert 62 = Aoc2020.Day9.part2(stream, search)
    end

    test "queue" do
      stream =
        """
        35
        20
        15
        25
        47
        40
        62
        55
        65
        95
        102
        117
        150
        182
        127
        219
        299
        277
        309
        576
        """
        |> String.split("\n", trim: true)
        |> Stream.map(&String.to_integer/1)

      search = Aoc2020.Day9.part1(stream, 5)

      assert 62 = Aoc2020.Day9.part2_queue(stream, search)
    end
  end
end
