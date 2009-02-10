set :application, 'ujumbe'
set :user,        'mtodd'
set :deploy_to,   "/var/www/#{application}"

set :scm, :git
set :local_repository, '.git'
set :repository,  "git://git/#{application}.git"
set :branch, 'master'
set :git_shallow_clone, 1
set :git_enable_submodules, true

set :group_writable, false
set :use_sudo, false

server 'your-server-here', :web, :app, :db, :primary => true, :user => user
