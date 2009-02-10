module AccountsHelper
  def prepare_new_account(account)
    account.tap { |account| account.users.build if account.users.empty? }
  end
end
