require 'test_helper'

class VcardTest < ActiveSupport::TestCase
  context 'a new Vcard' do
    setup { @vcard = Vcard.make_unsaved(:user => User.make) }

    should_not_allow_mass_assignment_of *any_attribute_other_than(:recipient, :name, :number)

    should_validate_presence_of :name
    should_validate_presence_of :number
  end
end