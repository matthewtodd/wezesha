require 'test_helper'

class SubscriberTest < ActiveSupport::TestCase
  should_validate_presence_of :email

  should_allow_values_for :email, 'developer@example.com'
  should_not_allow_values_for :email, 'developer'

  context 'with an existing Subscriber' do
    setup { Subscriber.make }
    should_validate_uniqueness_of :email, :case_sensitive => false
  end
end
