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
     require(File.join(File.dirname(__FILE__), 'config', 'boot'))

     require 'rake'
     require 'rake/testtask'
     require 'rake/rdoctask'
     require 'tasks/rails'

     Rake::Task['db:drop'].invoke
     Rake::Task['db:create'].invoke
     Rake::Task['substruct:db:bootstrap'].invoke
  end
  File.open(report, "a") {|f| f.puts "#{benchmark.to_s},n/a" }
