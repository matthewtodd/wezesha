require 'test_helper'

class AccountsHelperTest < ActionView::TestCase
  context 'with a new account' do
    setup { @account = Account.new }

    context 'prepare new account' do
      setup { prepare_new_account(@account) }
      should_change '@account.users.size'
    end

    context 'with a pre-built user' do
      setup { @account.users.build }

      context 'prepare new account' do
        setup { prepare_new_account(@account) }
        should_not_change '@account.users.size'
      end
    end
  end
end
