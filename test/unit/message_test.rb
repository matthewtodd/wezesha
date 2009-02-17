require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  should_validate_presence_of :text
  should_ensure_length_at_most :text, 160
  should_belong_to :user

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
