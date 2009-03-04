Rake::TaskManager.class_eval do
  def remove_task(task_name)
    @tasks.delete(task_name.to_s)
  end
end

def remove_task(task_name)
  Rake.application.remove_task(task_name)
end

remove_task :test
task :test => 'test:units'


begin
  require 'cucumber/rake/task'
  Cucumber::Rake::Task.new(:features) do |t|
    t.cucumber_opts = "--format progress --no-color"
  end
  task :features => 'db:test:prepare'
  task :default => ['test', 'features']
rescue LoadError
  puts "If you'd like to run the features, please install cucumber."
end