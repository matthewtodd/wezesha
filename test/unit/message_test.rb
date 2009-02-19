require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  # FIXME need to deal with this duplicate logic for mobile numbers
  should_validate_presence_of :recipient
  should_allow_values_for :recipient, '255712345678'
  should_not_allow_values_for :recipient, '254123456789', '255123', 'not numbers'

  should_validate_presence_of :text
  should_ensure_length_at_most :text, 160
  should_belong_to :user

  should 'not fail length validation when blank' do
    message = Message.new
    message.valid?
    assert_equal "can't be blank", message.errors.on(:text)
  end

  context 'a new Message' do
    setup { @message = Message.make_unsaved }

    context 'saved' do
      setup { @message.save }

      before_should 'deliver the Message via the MessageGateway' do
        MessageGateway.expects(:deliver).with(@message)
      end
    end
  end
end
