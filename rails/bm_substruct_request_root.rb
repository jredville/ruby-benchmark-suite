require File.dirname(__FILE__) + '/../lib/benchutils'
Dir.chdir 'substruct'

label = File.expand_path(__FILE__).sub(File.expand_path("..") + "/", "")
iterations = ARGV[-3].to_i
timeout = ARGV[-2].to_i
report = ARGV.last

ENV['RAILS_ENV'] = 'production'
     require(File.join(File.dirname(__FILE__), 'config', 'boot'))

     require 'rake'
     require 'rake/testtask'
     require 'rake/rdoctask'
     require 'tasks/rails'

     Rake::Task['db:drop'].invoke
     Rake::Task['db:create'].invoke
     Rake::Task['substruct:db:bootstrap'].invoke


require 'config/environment'
require 'application'
require 'action_controller/request_profiler'
ActionController::RequestProfiler.run(%w[-b -n1 request_root]) # warmup

  benchmark = BenchmarkRunner.new(label, iterations, timeout)
  benchmark.run do
    ActionController::RequestProfiler.run(%w[-b -n20 request_root])
  end
  File.open(report, "a") {|f| f.puts "#{benchmark.to_s},n/a" }
