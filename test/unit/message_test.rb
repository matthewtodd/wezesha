require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  context 'a binary Message' do
    setup do
      @message = Message.make_unsaved
      @message.stubs(:binary?).returns(true)
    end
    should_ensure_length_at_most :text, 280
  end

  context 'given a User' do
    setup { @user = User.make }
    
    context 'a new Message' do
      setup { @message = @user.messages.make_unsaved }
    
      should_validate_presence_of :recipient
      should_allow_values_for :recipient, '255712345678'
      should_not_allow_values_for :recipient, '254123456789', '255123', '+255712345689', 'not numbers'
    
      should_validate_presence_of :text
      should_ensure_length_at_most :text, 160
      should_belong_to :user
    
      context 'saved' do
        setup { @message.save }
    
        before_should 'deliver the Message via the MessageGateway' do
          MessageGateway.expects(:deliver).with(@message)
        end
    
        before_should 'charge the account for itself' do
          @message.account.expects(:charge_for).with(@message)
        end
      end
    end

    context 'with insufficient balance' do
      setup { @user.stubs(:sufficient_balance_for?).returns(false) }

      should 'invalidate Messages' do
        assert !Message.make_unsaved(:user => @user).valid?
      end
    end
  end

  context 'cost' do
    should 'be 5 for a simple text message' do
      assert_equal Money.new(5), Message.make.cost
    end
  end
end
