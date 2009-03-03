require 'test_helper'

class InvitationTest < ActiveSupport::TestCase
  should_not_allow_mass_assignment_of *any_attribute_other_than(:email)
  
  should_validate_presence_of :email
  should_allow_values_for :email, 'developer@example.com'
  should_not_allow_values_for :email, 'developer'
  should_belong_to :source

  context 'creating an Invitation' do
    setup { @invitation = Invitation.make }

    should 'set its code' do
      assert_not_nil @invitation.code
    end
  end
end
