def current_account
  @current_account ||= Account.first
end

def load_account(subdomain)
  @current_account = Account.find_by_subdomain!(subdomain)
end

Given /^the (.+) account has (\d+) dollars in it$/ do |subdomain, amount|
  load_account(subdomain)
  current_account.entries.delete_all
  current_account.entries.create(:amount => Money.dollars(amount.to_i))
end

Then /^the (.+) account should have (\d+) dollars in it$/ do |subdomain, amount|
  load_account(subdomain)
  assert_equal Money.dollars(amount.to_i), current_account.balance
end

Then /^the (.+) account should have less than (\d+) dollars in it$/ do |subdomain, amount|
  load_account(subdomain)
  assert current_account.balance < Money.dollars(amount.to_i)
end

