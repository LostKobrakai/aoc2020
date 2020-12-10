defmodule Aoc2020.Day10Test do
  use ExUnit.Case, async: true

  describe "part 1" do
    test "example 1" do
      stream =
        """
        16
        10
        15
        5
        1
        11
        7
        19
        6
        12
        4
        """
        |> String.split("\n", trim: true)
        |> Stream.map(&String.to_integer/1)

      assert 35 = Aoc2020.Day10.part1(stream)
    end

    test "example 2" do
      stream =
        """
        28
        33
        18
        42
        31
        14
        46
        20
        48
        47
        24
        23
        49
        45
        19
        38
        39
        11
        1
        32
        25
        35
        8
        17
        7
        9
        4
        2
        34
        10
        3
        """
        |> String.split("\n", trim: true)
        |> Stream.map(&String.to_integer/1)

      assert 220 = Aoc2020.Day10.part1(stream)
    end
  end

  describe "part 2" do
    test "own" do
      stream =
        """
        3
        6
        9
        """
        |> String.split("\n", trim: true)
        |> Stream.map(&String.to_integer/1)

      assert 1 = Aoc2020.Day10.part2(stream)
    end

    test "example 1" do
      stream =
        """
        16
        10
        15
        5
        1
        11
        7
        19
        6
        12
        4
        """
        |> String.split("\n", trim: true)
        |> Stream.map(&String.to_integer/1)

      assert 8 = Aoc2020.Day10.part2(stream)
    end

    test "example 2" do
      stream =
        """
        28
        33
        18
        42
        31
        14
        46
        20
        48
        47
        24
        23
        49
        45
        19
        38
        39
        11
        1
        32
        25
        35
        8
        17
        7
        9
        4
        2
        34
        10
        3
        """
        |> String.split("\n", trim: true)
        |> Stream.map(&String.to_integer/1)

      assert 19208 = Aoc2020.Day10.part2(stream)
    end
  end
end
