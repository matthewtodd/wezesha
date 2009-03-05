load 'deploy' if respond_to?(:namespace) # cap2 differentiator
Dir['vendor/plugins/*/recipes/*.rb'].each { |plugin| load(plugin) }
load 'config/deploy'

namespace :deploy do
  namespace :application_yml do
    desc 'Write a production application.yml file into shared_path'
    task :default do
      builder = JoyentDeployment::ConfigurationBuilder.new('application.yml', fetch(:rails_env, 'production'))
      builder.gather(YAML.load_file(File.join(File.dirname(__FILE__), 'config', 'application.yml')).fetch('development'))
      builder.confirm
      put builder.result.to_yaml, "#{shared_path}/application.yml", :mode => 0600
    end

    desc 'Symlink the shared application.yml into the latest_release'
    task :symlink do
      run "ln -s #{shared_path}/application.yml #{latest_release}/config/application.yml"
    end

    after 'deploy:setup',           'deploy:application_yml'
    after 'deploy:finalize_update', 'deploy:application_yml:symlink'
  end
end
