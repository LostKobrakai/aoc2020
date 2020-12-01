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
# Estimated total run time: 14 s

# Benchmarking first solution...
# Benchmarking optimized...

# Name                     ips        average  deviation         median         99th %
# optimized             3.67 K        0.27 ms     ±7.03%        0.27 ms        0.34 ms
# first solution       0.157 K        6.35 ms     ±1.13%        6.34 ms        6.59 ms

# Comparison:
# optimized             3.67 K
# first solution       0.157 K - 23.29x slower +6.08 ms

Benchee.run(
  %{
    "first solution" => fn -> Aoc2020.Day1.day1_part2() end,
    "optimized" => fn -> Aoc2020.Day1.day1_part2_optimized() end
  }
)
