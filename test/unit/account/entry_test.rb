require 'test_helper'

class Account::EntryTest < ActiveSupport::TestCase
  should_not_allow_mass_assignment_of *any_attribute_other_than(:amount, :source)
  should_belong_to :account
end
