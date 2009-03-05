# Settings specified here will take precedence over those in config/environment.rb

# The test environment is used exclusively to run your application's
# test suite.  You never need to work with it otherwise.  Remember that
# your test database is "scratch space" for the test suite and is wiped
# and recreated between test runs.  Don't rely on the data there!
config.cache_classes = true

# Log error messages when you accidentally call methods on nil.
config.whiny_nils = true

# Show full error reports and disable caching
config.action_controller.consider_all_requests_local = true
config.action_controller.perform_caching             = false

# Disable request forgery protection in test environment
config.action_controller.allow_forgery_protection    = false

# Tell Action Mailer not to deliver emails to the real world.
# The :test delivery method accumulates sent emails in the
# ActionMailer::Base.deliveries array.
config.action_mailer.default_url_options = { :host => 'test.host' }
config.action_mailer.delivery_method     = :test

# Use SQL instead of Active Record's schema dumper when creating the test database.
# This is necessary if your schema can't be completely dumped by the schema dumper,
# like if you have constraints or database-specific column types
# config.active_record.schema_format = :sql

# Specify gems that this application depends on and have them installed with RAILS_ENV=test rake gems:install
config.gem 'faker', :version => '>= 0.3.1'
config.gem 'mocha', :version => '>= 0.9.3'
config.gem 'notahat-machinist', :lib => 'machinist', :source => 'http://gems.github.com/'
config.gem 'thoughtbot-shoulda', :lib => 'shoulda', :source => 'http://gems.github.com/'

# SubdomainFu would say the TLD of "test.host", the Rails default, is "host"
config.after_initialize do
  SubdomainFu.tld_size = 1
end

config.to_prepare do
  MessageGateway.implementation = MessageGateway::Test
end