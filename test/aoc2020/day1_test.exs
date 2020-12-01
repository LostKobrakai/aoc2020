defmodule Aoc2020.Day1Test do
  use ExUnit.Case, async: true

  test "solution 1" do
    assert {:ok, 651_651} = Aoc2020.Day1.day1_part1()
  end

  test "brute force" do
    assert {:ok, 651_651} = Aoc2020.Day1.day1_part1_alt()
  end

  test "for" do
    assert {:ok, 651_651} = Aoc2020.Day1.day1_part1_for()
  end
end
