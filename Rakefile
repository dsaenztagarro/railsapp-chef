#!/usr/bin/env rake
Dir.glob('lib/tasks/*.rake').each { |r| load r }

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
rescue LoadError
  puts '>>>>> RSpec gem not loaded, omitting tasks'
end

begin
  require 'kitchen/rake_tasks'
  Kitchen::RakeTasks.new
# rescue LoadError
rescue Exception => error
  puts '>>>>> Kitchen gem not loaded, omitting tasks' unless ENV['CI']
  puts ">>>>> #{error.message}"
end

begin
  require 'foodcritic'
  FoodCritic::Rake::LintTask.new
rescue LoadError
  puts '>>>>> FoodCritic gem not loaded, omitting tasks'
end

task default: [:foodcritic, :unit]
