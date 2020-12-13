defmodule Aoc2020.Day12 do
  defmodule Ship do
    defstruct location: {0, 0}, direction: {1, 0}
  end

  defmodule ShipWithWaypoint do
    defstruct location: {0, 0}, waypoint: {10, 1}
  end

  @north {0, 1}
  @south {0, -1}
  @east {1, 0}
  @west {-1, 0}

  def part1() do
    part1(load_input())
  end

  def part1(input) do
    ship = Enum.reduce(input, %Ship{}, &act/2)
    manhatten_distance(ship)
  end

  # Move ship in cardinal direction
  defp act(<<type::binary-size(1), num::binary>>, %Ship{} = ship)
       when type in ["N", "S", "E", "W"] do
    Map.update!(ship, :location, &vector_add(&1, cardinal_move(type, num)))
  end

  # Move in ship direction
  defp act(<<"F", num::binary>>, %Ship{} = ship) do
    movement = vector_multiply(ship.direction, String.to_integer(num))
    Map.update!(ship, :location, &vector_add(&1, movement))
  end

  # Turn ship
  defp act(<<type::binary-size(1), num::binary>>, %Ship{} = ship)
       when type in ["L", "R"] do
    Map.update!(ship, :direction, &rotate(&1, type, num))
  end

  defp cardinal_move("N", num), do: vector_multiply(@north, String.to_integer(num))
  defp cardinal_move("S", num), do: vector_multiply(@south, String.to_integer(num))
  defp cardinal_move("E", num), do: vector_multiply(@east, String.to_integer(num))
  defp cardinal_move("W", num), do: vector_multiply(@west, String.to_integer(num))

  # could be replaces with part 2's solution of using proper math
  defp rotate(current, type, num) when type in ["R", "L"] do
    turns = num |> String.to_integer() |> div(90)

    case type do
      "R" ->
        Stream.unfold(current, fn
          @east -> {@south, @south}
          @south -> {@west, @west}
          @west -> {@north, @north}
          @north -> {@east, @east}
        end)

      "L" ->
        Stream.unfold(current, fn
          @east -> {@north, @north}
          @north -> {@west, @west}
          @west -> {@south, @south}
          @south -> {@east, @east}
        end)
    end
    |> Enum.at(turns - 1)
  end

  defp vector_add({x1, y1}, {x2, y2}), do: {x1 + x2, y1 + y2}
  defp vector_multiply({x1, y1}, x), do: {to_int(x1 * x), to_int(y1 * x)}

  def vector_rotate({x1, y1}, degree) do
    rad = degree * :math.pi() / 180

    {to_int(:math.cos(rad) * x1 - :math.sin(rad) * y1),
     to_int(:math.sin(rad) * x1 + :math.cos(rad) * y1)}
  end

  def to_int(int) when is_integer(int), do: int
  def to_int(float), do: float |> Float.round() |> trunc()

  defp manhatten_distance(%{location: {x, y}}) do
    abs(x) + abs(y)
  end

  def part2() do
    part2(load_input())
  end

  def part2(input) do
    ship = Enum.reduce(input, %ShipWithWaypoint{}, &act_waypoint/2)
    manhatten_distance(ship)
  end

  # Move waypoint in cardinal direction
  defp act_waypoint(<<type::binary-size(1), num::binary>>, %ShipWithWaypoint{} = ship)
       when type in ["N", "S", "E", "W"] do
    Map.update!(ship, :waypoint, &vector_add(&1, cardinal_move(type, num)))
  end

  # Move ship to waypoint
  defp act_waypoint(<<"F", num::binary>>, %ShipWithWaypoint{} = ship) do
    movement = vector_multiply(ship.waypoint, String.to_integer(num))
    Map.update!(ship, :location, &vector_add(&1, movement))
  end

  # Turn waypoint
  defp act_waypoint(<<type::binary-size(1), num::binary>>, %ShipWithWaypoint{} = ship)
       when type in ["L", "R"] do
    Map.update!(ship, :waypoint, &rotate_around_ship(&1, type, num))
  end

  defp rotate_around_ship(current, "L", num) do
    vector_rotate(current, String.to_integer(num))
  end

  defp rotate_around_ship(current, "R", num) do
    vector_rotate(current, -1 * String.to_integer(num))
  end

  @doc false
  def load_input do
    path = Application.app_dir(:aoc_2020, "priv/inputs/12/instructions.txt")

    path
    |> File.stream!()
    |> Stream.map(&String.trim/1)
  end
end
