list = Aoc2020.Day1.load_report()

Benchee.run(%{
  "first solution" => fn ->
    try do
      for x <- list, y <- list, z <- list, x + y + z == 2020 do
        throw(x * y * z)
      end

      :error
    catch
      num -> {:ok, num}
    end
  end,
  "no short circuit" => fn ->
    [num | _] =
      for x <- list, y <- list, z <- list, x + y + z == 2020 do
        x * y * z
      end

    num
  end,
  "optimized, no short circuit" => fn ->
    [num | _] =
      for x <- list,
          rest = 2020 - x,
          y <- list,
          y < rest,
          rest = 2020 - x - y,
          z <- list,
          z <= rest,
          x + y + z == 2020,
          do: x * y * z
  end,
  "optimized" => fn ->
    try do
      for x <- list,
          rest = 2020 - x,
          y <- list,
          y < rest,
          rest = 2020 - x - y,
          z <- list,
          z <= rest,
          x + y + z == 2020,
          do: throw(x * y * z)

      :error
    catch
      num -> {:ok, num}
    end
  end
})
