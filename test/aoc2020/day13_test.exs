defmodule Aoc2020.Day13Test do
  use ExUnit.Case, async: true
  require Logger

  describe "part 1" do
    test "example 1" do
      input = """
      939
      7,13,x,x,59,x,31,19
      """

      assert 295 = Aoc2020.Day13.part1(input)
    end
  end

  describe "part 2" do
    test "example 1" do
      input = """
      939
      7,13,x,x,59,x,31,19
      """

      assert 1_068_781 = Aoc2020.Day13.part2(input)
    end

    test "example 2" do
      input = """
      -
      17,x,13,19
      """

      assert 3417 = Aoc2020.Day13.part2(input)
    end

    test "example 3" do
      input = """
      -
      67,7,59,61
      """

      assert 754_018 = Aoc2020.Day13.part2(input)
    end

    test "example 4" do
      input = """
      -
      67,x,7,59,61
      """

      assert 779_210 = Aoc2020.Day13.part2(input)
    end

    test "example 5" do
      input = """
      -
      67,7,x,59,61
      """

      assert 1_261_476 = Aoc2020.Day13.part2(input)
    end

    test "example 6" do
      input = """
      -
      1789,37,47,1889
      """

      assert 1_202_161_486 = Aoc2020.Day13.part2(input)
    end
  end
end
