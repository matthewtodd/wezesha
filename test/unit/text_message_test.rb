require 'test_helper'

class TextMessageTest < ActiveSupport::TestCase
  should_not_allow_mass_assignment_of *any_attribute_other_than(:recipient, :text)

  context 'given sufficient credit, a new Text' do
    setup { @text_message = User.make(:with_credit).text_messages.make_unsaved }

    should_validate_presence_of :recipient
    should_allow_values_for :recipient, '255712345678'
    should_not_allow_values_for :recipient, '254123456789', '255123', '+255712345689', 'not numbers'

    should_validate_presence_of :text
    should_ensure_length_in_range :text, 1..160, :short_message => :blank
    should_belong_to :user

    should 'cost 5 cents' do
      assert_equal Money.cents(5), @text_message.cost
    end

    context 'saved' do
      setup { @text_message.save! }

      before_should 'deliver the Message via the MessageGateway' do
        MessageGateway.expects(:deliver).with(@text_message)
      end

      before_should 'charge the account for itself' do
        @text_message.account.expects(:charge_for).with(@text_message)
      end
    end
  end

  context 'without sufficient credit, a new Text' do
    setup { @text_message = TextMessage.make_unsaved }

    should 'not be valid' do
      assert !@text_message.valid?
    end
  end
end
