defmodule Aoc2020Test do
  use ExUnit.Case, async: true
  doctest Aoc2020

  test "Day 1: Report Repair - Part 1" do
    assert {:ok, 651_651} = Aoc2020.day1_part1()
  end

  test "Day 1: Report Repair - Part 2" do
    assert {:ok, 214_486_272} = Aoc2020.day1_part2()
  end

  test "Day 2: Password Philosophy - Part 1" do
    assert 416 = Aoc2020.day2_part1()
  end

  test "Day 2: Password Philosophy - Part 2" do
    assert 688 = Aoc2020.day2_part2()
  end

  test "Day 3: Toboggan Trajectory - Part 1" do
    assert 169 = Aoc2020.day3_part1()
  end

  test "Day 3: Toboggan Trajectory - Part 2" do
    assert 7_560_370_818 = Aoc2020.day3_part2()
  end

  test "Day 4: Passport Processing - Part 1" do
    assert 245 = Aoc2020.day4_part1()
  end

  test "Day 4: Passport Processing - Part 2" do
    assert 133 = Aoc2020.day4_part2()
  end

  test "Day 5: Binary Boarding - Part 1" do
    assert 826 = Aoc2020.day5_part1()
  end

  test "Day 5: Binary Boarding - Part 2" do
    assert 678 = Aoc2020.day5_part2()
  end

  test "Day 6: Custom Customs - Part 1" do
    assert 6778 = Aoc2020.day6_part1()
  end

  test "Day 6: Custom Customs - Part 2" do
    assert 3406 = Aoc2020.day6_part2()
  end

  test "Day 7: Handy Haversacks - Part 1" do
    assert 242 = Aoc2020.day7_part1()
  end

  test "Day 7: Handy Haversacks - Part 2" do
    assert 176_035 = Aoc2020.day7_part2()
  end

  test "Day 8: Handheld Halting - Part 1" do
    assert 1753 = Aoc2020.day8_part1()
  end

  test "Day 8: Handheld Halting - Part 2" do
    assert 733 = Aoc2020.day8_part2()
  end

  test "Day 9: Encoding Error - Part 1" do
    assert 105_950_735 = Aoc2020.day9_part1()
  end

  test "Day 9: Encoding Error - Part 2" do
    assert 13_826_915 = Aoc2020.day9_part2()
  end

  test "Day 10: Adapter Array - Part 1" do
    assert 2046 = Aoc2020.day10_part1()
  end

  test "Day 10: Adapter Array - Part 2" do
    assert 1_157_018_619_904 = Aoc2020.day10_part2()
  end

  test "Day 11: Seating System - Part 1" do
    assert 2310 = Aoc2020.day11_part1()
  end

  test "Day 11: Seating System - Part 2" do
    assert 2074 = Aoc2020.day11_part2()
  end

  test "Day 12: Rain Risk - Part 1" do
    assert 1319 = Aoc2020.day12_part1()
  end

  test "Day 12: Rain Risk - Part 2" do
    assert 62434 = Aoc2020.day12_part2()
  end
end
