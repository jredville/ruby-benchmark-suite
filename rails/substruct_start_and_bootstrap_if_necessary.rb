Dir.chdir 'substruct'
ENV['RAILS_ENV'] = 'production'
require(File.join(File.dirname(__FILE__), 'config', 'boot'))
require 'config/environment'
require 'application'

begin
 Product.first # raising here means the DB doesn't exist
rescue Exception
     require 'rake'
     require 'rake/testtask'
     require 'rake/rdoctask'
     require 'tasks/rails'
     Rake::Task['db:create'].invoke
     Rake::Task['substruct:db:bootstrap'].invoke
end

