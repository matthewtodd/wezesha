require 'cucumber/rake/task'

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

Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = "--format progress --no-color"
end

task :features => 'db:test:prepare'
task :default => ['test', 'features']
