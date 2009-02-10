require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  should_have_many :users
  should_accept_nested_attributes_for :users

  context 'given an existing account' do
    setup { Account.create!(:subdomain => 'foo') }
    should_validate_uniqueness_of :subdomain
  end
end
