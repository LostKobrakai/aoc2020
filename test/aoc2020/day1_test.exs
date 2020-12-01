defmodule Aoc2020.Day1Test do
  use ExUnit.Case, async: true

  describe "part 1" do
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

  describe "part 2" do
    test "solution 1" do
      assert {:ok, 214_486_272} = Aoc2020.Day1.day1_part2()
    end

    test "optimized" do
      assert {:ok, 214_486_272} = Aoc2020.Day1.day1_part2_optimized()
    end
  end
end
