require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  should_not_allow_mass_assignment_of *any_attribute_other_than(:invitation_code, :subdomain, :users_attributes)

  should_validate_presence_of :invitation_id, :message => :invalid
  should_validate_presence_of :subdomain
  should_not_allow_values_for :subdomain, 'admin', 'api', 'blog', 'developer', 'docs', 'example', 'gems', 'help', 'mail', 'pop', 'pop3', 'imap', 'sample', 'site', 'smtp', 'staging', 'stats', 'status', 'support', 'test', 'testing', 'www', :message => :exclusion
  should_not_allow_values_for :subdomain, 'CAPITALS', 's p a c e s', '123456789', 'hy-phe-na-ted', '_underscored_', :message => 'may only contain lowercase letters'

  should_belong_to :invitation
  should_have_many :users
  should_accept_nested_attributes_for :users
  should_have_many :entries

  context 'given an existing Invitation' do
    setup { @invitation = Invitation.make }

    context "making an Account with that Invitation's code" do
      setup { @account = Account.make(:invitation_code => @invitation.code) }

      should "set the Account's Invitation to that Invitation" do
        assert_equal @invitation, @account.invitation
      end

      should "prevent other accounts from using that same code" do
        other_account = Account.make_unsaved(:invitation_code => @invitation.code)
        other_account.valid?
        assert_equal 'has already been taken', other_account.errors.on(:invitation_id)
      end
    end
  end

  context 'making an account with a non-existent Invitation code' do
    setup { @account = Account.make_unsaved(:invitation_code => 'THERE IS NO WAY THIS INVITATION CODE EXISTS') }

    should 'set a custom error message on the Invitation' do
      @account.valid?
      assert_contains @account.errors.on(:invitation_id).to_a, 'is invalid'
    end
  end

  context 'a newly-created Account' do
    setup { @account = Account.make }

    should_validate_uniqueness_of :invitation_id
    should_validate_uniqueness_of :subdomain

    should 'have 0 balance by default' do
      assert_equal Money.new(0), @account.balance
    end

    should 'not have enough credit to send a message' do
      assert !@account.sufficient_balance_for?(Message.make_unsaved)
    end

    context 'with some entries in it' do
      setup do
        @account.entries.create(:amount => Money.new(400))
        @account.entries.create(:amount => Money.new(600))
      end

      should 'have balance equal to the sum of the entries' do
        assert_equal Money.new(1000), @account.balance
      end

      should 'have enough credit to send a message' do
        assert @account.sufficient_balance_for?(Message.make_unsaved)
      end
    end
  end
end
