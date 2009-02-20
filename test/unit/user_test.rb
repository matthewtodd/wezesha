require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should_not_allow_mass_assignment_of *any_attribute_other_than(:email, :password, :password_confirmation)

  should_be_authentic
  should_belong_to :account
  should_have_many :messages
end
