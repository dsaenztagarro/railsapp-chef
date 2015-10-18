namespace :style do

  begin
    require 'reek/rake/task'
    Reek::Rake::Task.new do |t|
      t.fail_on_error = false
    end
  rescue LoadError
    puts '>>>>> Reek gem not loaded, omitting tasks'
  end

  begin
    require 'foodcritic'
    FoodCritic::Rake::LintTask.new
  rescue LoadError
    puts '>>>>> FoodCritic gem not loaded, omitting tasks'
  end

  task all: [:reek, :foodcritic]
end
