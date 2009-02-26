require 'test_helper'

class SubscriberTest < ActiveSupport::TestCase
  should_validate_presence_of :email

  should_allow_values_for :email, 'developer@example.com'
  should_not_allow_values_for :email, 'developer'

  should_have_many :invitations

  context 'an existing Subscriber' do
    setup { @subscriber = Subscriber.make }

    context 'building an Invitation' do
      setup { @invitation = @subscriber.invitations.build }
      should 'set email to the Subscriber email' do
        assert_equal(@subscriber.email, @invitation.email)
      end
    end

    should 'not set email when building an Invitation with a specific email address as a symbol' do
      invitation = @subscriber.invitations.build(:email => Sham.email)
      assert_not_equal(@subscriber.email, invitation.email)
    end

    should 'not set email when building an Invitation with a specific email address as a string' do
      invitation = @subscriber.invitations.build('email' => Sham.email)
      assert_not_equal(@subscriber.email, invitation.email)
    end

    should 'not blow up building an Invitation with nil parameters' do
      assert_nothing_raised { @subscriber.invitations.build(nil) }
    end
  end
end
