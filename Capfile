load 'deploy' if respond_to?(:namespace) # cap2 differentiator
Dir['vendor/plugins/*/recipes/*.rb'].each { |plugin| load(plugin) }
load 'config/deploy'

after 'deploy:finalize_update' do
  run "ln -s #{shared_path}/application.yml #{latest_release}/config/application.yml"
end