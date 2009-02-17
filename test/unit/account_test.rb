require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  should_not_allow_mass_assignment_of *any_attribute_other_than(:subdomain, :users_attributes)

  should_validate_presence_of :subdomain
  should_not_allow_values_for :subdomain, 'admin', 'api', 'blog', 'developer', 'docs', 'example', 'gems', 'help', 'mail', 'pop', 'pop3', 'imap', 'sample', 'site', 'smtp', 'staging', 'stats', 'status', 'support', 'test', 'testing', 'www', :message => :exclusion
  should_not_allow_values_for :subdomain, 'CAPITALS', 's p a c e s', '123456789', 'hy-phe-na-ted', '_underscored_', :message => 'may only contain lowercase letters'
  should_have_many :users
  should_accept_nested_attributes_for :users

  context 'given an existing account' do
    setup { Account.create!(:subdomain => 'foo') }
    should_validate_uniqueness_of :subdomain
  end
end
