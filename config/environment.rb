# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.0' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  # Specify gems that this application depends on and have them installed with rake gems:install
  config.gem 'activemerchant', :lib => 'active_merchant'
  config.gem 'authlogic'
  config.gem 'haml'
  config.gem 'matthewtodd-default_association_attributes', :lib => 'default_association_attributes', :source => 'http://gems.github.com'
  config.gem 'mbleigh-subdomain-fu', :lib => 'subdomain-fu', :source => 'http://gems.github.com'
  config.gem 'RedCloth', :lib => 'redcloth'

  # Activate observers that should always be running
  # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

  # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
  # Run "rake -D time" for a list of tasks for finding time zone names.
  config.time_zone = 'UTC'

  config.i18n.load_path << Rails.root.join('vendor', 'rails-i18n', 'rails', 'locale', 'sw.yml')

  config.action_controller.session = { :key => '_wezesha_session', :secret => File.read(Rails.root.join('config', 'secret.txt')).strip }

  config.after_initialize do
    ActionMailer::Base.delivery_method               = Application[:action_mailer_delivery_method]
    ActionMailer::Base.default_url_options[:host]    = Application[:action_mailer_host]
    ActionMailer::Base.sendmail_settings[:location]  = Application[:action_mailer_sendmail_location]
    ActionMailer::Base.sendmail_settings[:arguments] = Application[:action_mailer_sendmail_arguments]

    ActionView::Base.default_form_builder = ApplicationHelper::LocalizedFormBuilder
  end
end