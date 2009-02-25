# Sets up the Rails environment for Cucumber
ENV['RAILS_ENV'] = 'test'
require File.expand_path(File.dirname(__FILE__) + '/../../config/environment')
require File.expand_path(File.dirname(__FILE__) + '/../../test/blueprints')
require 'cucumber/rails/world'
require 'cucumber/formatters/unicode' # Comment out this line if you don't want Cucumber Unicode support
Cucumber::Rails.use_transactional_fixtures

require 'webrat'

Webrat.configure do |config|
  config.mode = :rails
end

# Comment out the next two lines if you're not using RSpec's matchers (should / should_not) in your steps.
# require 'cucumber/rails/rspec'
# require 'webrat/rspec-rails'

# Seed the Database
Fixtures.reset_cache
fixtures_folder = Rails.root.join('features', 'support', 'fixtures')
fixtures = Dir[File.join(fixtures_folder, '*.yml')].map {|f| File.basename(f, '.yml') }
Fixtures.create_fixtures(fixtures_folder, fixtures)

Before do
  # Forget any messages from previous Scenarios
  MessageGateway.messages.clear

  # Reset to the default locale before each Scenario
  I18n.locale = I18n.default_locale
end
