# Operating System: macOS
# CPU Information: AMD Ryzen 5 3600X 6-Core Processor
# Number of Available Cores: 12
# Available memory: 16 GB
# Elixir 1.11.1
# Erlang 23.0

# Benchmark suite executing with the following configuration:
# warmup: 2 s
# time: 5 s
# memory time: 0 ns
# parallel: 1
# inputs: none specified
# Estimated total run time: 21 s

# Benchmarking first attempt...
# Benchmarking mapset...
# Benchmarking optimized...

# Name                    ips        average  deviation         median         99th %
# optimized            418.92        2.39 ms     ±3.39%        2.38 ms        2.63 ms
# mapset               317.26        3.15 ms     ±3.69%        3.14 ms        3.44 ms
# first attempt        254.41        3.93 ms     ±3.36%        3.91 ms        4.29 ms

# Comparison:
# optimized            418.92
# mapset               317.26 - 1.32x slower +0.76 ms
# first attempt        254.41 - 1.65x slower +1.54 ms
input = Aoc2020.Day6.load_input()

Benchee.run(%{
  "first attempt" => fn -> Aoc2020.Day6.part2(input) end,
  "mapset" => fn -> Aoc2020.Day6.part2_mapset(input) end,
  "optimized" => fn -> Aoc2020.Day6.part2_optimized(input) end
})
