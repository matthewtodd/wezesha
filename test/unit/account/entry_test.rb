require 'test_helper'

class Account::EntryTest < ActiveSupport::TestCase
  should_belong_to :account
end
