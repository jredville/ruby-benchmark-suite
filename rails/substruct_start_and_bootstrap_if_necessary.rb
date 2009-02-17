Dir.chdir 'substruct'

ENV['RAILS_ENV'] = 'production'
if RUBY_PLATFORM =~ /mswin|mingw/
  require(File.join(File.dirname(__FILE__), 'config', 'boot')) # windows weirdness
else
  require(File.join(File.dirname(__FILE__), 'substruct', 'config', 'boot'))
end

require 'config/environment'
require 'application'

begin
 Product.first # raising here means the DB doesn't exist
 puts 'database appears initialized'
rescue Exception
     puts 'recreating database'
     require 'rake'
     require 'rake/testtask'
     require 'rake/rdoctask'
     require 'tasks/rails'
     Rake::Task['db:create'].invoke
     Rake::Task['substruct:db:bootstrap'].invoke
end

