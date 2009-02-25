require 'test_helper'

class SubscriptionTest < ActiveSupport::TestCase
  should_validate_presence_of :email

  should_allow_values_for :email, 'developer@example.com'
  should_not_allow_values_for :email, 'developer'

  context 'with an existing subscription' do
    setup { Subscription.make }
    should_validate_uniqueness_of :email, :case_sensitive => false
  end
end
