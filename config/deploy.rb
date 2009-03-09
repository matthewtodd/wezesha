set :application, 'wezesha'
set :user,        'matthew'
set :database,    "#{user}_#{application}_production"
set :domain_path, "/users/home/#{user}/domains/wezesha.co.tz"
set :deploy_to,   "#{domain_path}/var/www"

set :scm, :git
set :local_repository, '.git'
set :repository,  "git://github.com/matthewtodd/#{application}.git"
set :branch, 'master'
set :deploy_via, :remote_cache
set :git_enable_submodules, true

set :group_writable, false
set :use_sudo, false

server 'woodward.joyent.us', :web, :app, :db, :primary => true, :user => user