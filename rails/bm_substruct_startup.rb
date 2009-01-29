require File.dirname(__FILE__) + '/../lib/benchutils'
Dir.chdir 'substruct'

label = File.expand_path(__FILE__).sub(File.expand_path("..") + "/", "")
iterations = ARGV[-3].to_i
timeout = ARGV[-2].to_i
report = ARGV.last

# For some benchmarks it doesn't even make sense to have variable input sizes.
# If this is the case, feel free to remove the outer block that iterates over the array.
  benchmark = BenchmarkRunner.new(label, iterations, timeout)
  benchmark.run do
    substruct_start_and_bootstrap_if_necessary.rb
  end
  File.open(report, "a") {|f| f.puts "#{benchmark.to_s},n/a" }
