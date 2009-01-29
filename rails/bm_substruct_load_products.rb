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

1000.times { |n|
 Product.create :name => "name", :code => n
}

  benchmark = BenchmarkRunner.new(label, iterations, timeout)
  benchmark.run do
    Product.find(:all)
  end
  File.open(report, "a") {|f| f.puts "#{benchmark.to_s},n/a" }
