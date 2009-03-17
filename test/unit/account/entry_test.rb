require 'test_helper'

class Account::EntryTest < ActiveSupport::TestCase
  should_allow_mass_assignment_of :amount, :cents, :source
  should_not_allow_mass_assignment_of *any_attribute_other_than(:amount, :cents, :source)
  should_belong_to :account
  should_validate_presence_of :cents
  should_validate_numericality_of :cents
end
