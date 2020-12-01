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
