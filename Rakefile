# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require(File.join(File.dirname(__FILE__), 'config', 'boot'))

require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

Rake::TestTask.class_eval do
  alias_method :crufty_define, :define
  def define
    @verbose = false
    crufty_define
  end
end

require 'tasks/rails'
