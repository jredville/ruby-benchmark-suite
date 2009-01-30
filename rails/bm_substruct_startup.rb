require File.dirname(__FILE__) + '/../lib/benchutils'

label = File.expand_path(__FILE__).sub(File.expand_path("..") + "/", "")
iterations = ARGV[-3].to_i
timeout = ARGV[-2].to_i
report = ARGV.last

# For some benchmarks it doesn't even make sense to have variable input sizes.
# If this is the case, feel free to remove the outer block that iterates over the array.
  benchmark = BenchmarkRunner.new(label, iterations, timeout)
  # unfortunately there's no easy way to load the startup multiple times and have it work on windows, too
  first_time_through_time =  nil
  benchmark.run do
    if first_time_through_time
      sleep  first_time_through_time
    else
       first_time_through_time = Benchmark.realtime {require 'substruct_start_and_bootstrap_if_necessary.rb'}
    end
  end
  File.open(report, "a") {|f| f.puts "#{benchmark.to_s},n/a" }
