load 'deploy' if respond_to?(:namespace) # cap2 differentiator
Dir['vendor/plugins/*/recipes/*.rb'].each { |plugin| load(plugin) }
load 'config/deploy'

after 'deploy:setup' do
  application_configuration = { 
    'secret' => ActiveSupport::SecureRandom.hex(64)
  }
  
  database_configuration = {
    'adapter' => 'mysql'
    'database' => ask("Enter the database name: ")
    'username' => user
    'password' => password_prompt("Enter the database password for #{user}: ")
    'socket' => '/tmp/mysql.sock'
  }
  
  def keyed_under_current_environment(value)
    { fetch(:rails_env, 'production') => value }
  end
  
  put keyed_under_current_environment(application_configuration).to_yaml, "#{shared_path}/application.yml", :mode => 0600
  put keyed_under_current_environment(database_configuration).to_yaml, "#{shared_path}/database.yml", :mode => 0600
end

after 'deploy:finalize_update' do
  run "ln -s #{shared_path}/application.yml #{latest_release}/config/application.yml"
  run "ln -s #{shared_path}/database.yml #{latest_release}/config/database.yml"
end
