require 'test_helper'

class VcardTest < ActiveSupport::TestCase
  def maximum_vcard_characters_given_total_length_of(length)
    vcard = Vcard.make_unsaved(:name => '', :number => '')
    vcard.valid?
    (length - vcard.text.length) / 2
  end

  context 'a new Vcard' do
    setup { @vcard = User.make(:with_credit).vcards.make_unsaved }

    should_not_allow_mass_assignment_of *any_attribute_other_than(:recipient, :name, :number)

    should_validate_presence_of :name
    should_validate_presence_of :number

    context 'setting the name to the maximum allowed' do
      setup do
        @vcard.name = 'x' * (maximum_vcard_characters_given_total_length_of(280) - @vcard.number.length)
      end

      should 'not invalidate the Vcard' do
        assert_valid @vcard
      end

      context 'and then adding one character to the name' do
        setup { @vcard.name += 'x' }

        should 'invalidate the Vcard' do
          assert !@vcard.valid?
        end
      end
    end
  end
end