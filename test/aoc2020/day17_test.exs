defmodule Aoc2020.Day17Test do
  use ExUnit.Case, async: true
  alias Aoc2020.Day17.Game
  alias Aoc2020.Day17.Game4D

  describe "part 1" do
    test "example 1" do
      input = """
      .#.
      ..#
      ###
      """

      game = Aoc2020.Day17.Game.new(input)
      [cycle_1, cycle_2, cycle_3] = Enum.take(game, 3)

      assert """
             #..
             ..#
             .#.\
             """ = Game.state_at(cycle_1, -1)

      assert """
             #.#
             .##
             .#.\
             """ = Game.state_at(cycle_1, 0)

      assert """
             #..
             ..#
             .#.\
             """ = Game.state_at(cycle_1, 1)

      assert """
             .....
             .....
             ..#..
             .....
             .....\
             """ = Game.state_at(cycle_2, -2)

      assert """
             ..#..
             .#..#
             ....#
             .#...
             .....\
             """ = Game.state_at(cycle_2, -1)

      assert """
             ##...
             ##...
             #....
             ....#
             .###.\
             """ = Game.state_at(cycle_2, 0)

      assert """
             ..#..
             .#..#
             ....#
             .#...
             .....\
             """ = Game.state_at(cycle_2, 1)

      assert """
             .....
             .....
             ..#..
             .....
             .....\
             """ = Game.state_at(cycle_2, 2)
    end

    test "running" do
      input = """
      .#.
      ..#
      ###
      """

      assert 112 = Aoc2020.Day17.part1(input)
    end
  end

  describe "part 2" do
    test "example 1" do
      input = """
      .#.
      ..#
      ###
      """

      game = Aoc2020.Day17.Game4D.new(input)
      [cycle_1, cycle_2, cycle_3] = Enum.take(game, 3)

      assert """
             #..
             ..#
             .#.\
             """ = Game4D.state_at(cycle_1, -1, -1)

      assert """
             #..
             ..#
             .#.\
             """ = Game4D.state_at(cycle_1, 0, -1)

      assert """
             #..
             ..#
             .#.\
             """ = Game4D.state_at(cycle_1, 1, -1)

      assert """
             #..
             ..#
             .#.\
             """ = Game4D.state_at(cycle_1, -1, 0)

      assert """
             #.#
             .##
             .#.\
             """ = Game4D.state_at(cycle_1, 0, 0)

      assert """
             #..
             ..#
             .#.\
             """ = Game4D.state_at(cycle_1, 1, 0)

      assert """
             #..
             ..#
             .#.\
             """ = Game4D.state_at(cycle_1, -1, 1)

      assert """
             #..
             ..#
             .#.\
             """ = Game4D.state_at(cycle_1, 0, 1)

      assert """
             #..
             ..#
             .#.\
             """ = Game4D.state_at(cycle_1, 1, 1)
    end

    test "running" do
      input = """
      .#.
      ..#
      ###
      """

      assert 112 = Aoc2020.Day17.part1(input)
    end
  end
end
