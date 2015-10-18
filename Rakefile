#!/usr/bin/env rake
Dir.glob('lib/tasks/*.rake').each { |r| load r}

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
rescue LoadError
  puts '>>>>> RSpec gem not loaded, omitting tasks'
end

begin
  require 'kitchen/rake_tasks'
  Kitchen::RakeTasks.new
rescue LoadError
  puts '>>>>> Kitchen gem not loaded, omitting tasks' unless ENV['CI']
end

task default: [:foodcritic, :unit]
