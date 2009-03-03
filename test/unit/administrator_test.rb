require 'test_helper'

class AdministratorTest < ActiveSupport::TestCase
  should_not_allow_mass_assignment_of *any_attribute_other_than(:email, :password, :password_confirmation)
end
