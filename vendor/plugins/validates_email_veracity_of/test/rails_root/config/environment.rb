require File.join(File.dirname(__FILE__), 'boot')

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.1.0' unless defined? RAILS_GEM_VERSION

Rails::Initializer.run do |config|
  config.log_level = :debug
  config.cache_classes = false
  config.whiny_nils = true
  config.load_paths << "#{File.dirname(__FILE__)}/../../../lib/"
end

Dependencies.log_activity = true
