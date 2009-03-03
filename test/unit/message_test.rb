require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  context 'given sufficient credit, a new Message' do
    setup { @message = Message.make_unsaved(:user => User.make(:with_credit)) }

    should_validate_presence_of :recipient
    should_allow_values_for :recipient, '255712345678'
    should_not_allow_values_for :recipient, '254123456789', '255123', '+255712345689', 'not numbers'

    should_validate_presence_of :text
    should_ensure_length_at_most :text, 160
    should_belong_to :user

    should 'cost 5 cents' do
      assert_equal Money.cents(5), @message.cost
    end

    context 'saved' do
      setup { @message.save! }

      before_should 'deliver the Message via the MessageGateway' do
        MessageGateway.expects(:deliver).with(@message)
      end

      before_should 'charge the account for itself' do
        @message.account.expects(:charge_for).with(@message)
      end
    end
  end

  context 'without sufficient credit, a new Message' do
    setup { @message = Message.make_unsaved }

    should 'not be valid' do
      assert !@message.valid?
    end
  end

  context 'a binary Message' do
    setup do
      @message = Message.make_unsaved
      @message.stubs(:binary?).returns(true)
    end

    should_ensure_length_at_most :text, 280
  end
end
