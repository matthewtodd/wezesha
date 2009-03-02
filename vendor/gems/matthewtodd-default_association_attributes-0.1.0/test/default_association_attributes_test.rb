require File.join(File.dirname(__FILE__), 'test_helper')

class DefaultAssociationAttributesTest < Test::Unit::TestCase
  context 'given an existing Subscriber' do
    setup { @subscriber = Subscriber.create(:email => 'developer@example.com') }

    [:build, :create].each do |method|
      context "#{method} Invitation" do
        setup { @invitation = @subscriber.invitations.send(method) }

        should 'set email to the Subscriber email' do
          assert_equal(@subscriber.email, @invitation.email)
        end
      end

      should "not set email on #{method} Invitation with a specific email address as a symbol" do
        invitation = @subscriber.invitations.send(method, :email => 'someone.else@example.com')
        assert_equal('someone.else@example.com', invitation.email)
      end

      should "not set email on #{method} Invitation with a specific email address as a string" do
        invitation = @subscriber.invitations.send(method, 'email' => 'someone.else@example.com')
        assert_equal('someone.else@example.com', invitation.email)
      end

      should "not blow up on #{method} Invitation with nil parameters" do
        assert_nothing_raised { @subscriber.invitations.send(method, nil) }
      end
    end
  end
end