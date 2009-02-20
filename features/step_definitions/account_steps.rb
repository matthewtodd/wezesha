def current_account
  @current_account ||= Account.first
end

def load_account(subdomain)
  @current_account = Account.find_by_subdomain!(subdomain)
end

Given /^the (.+) account has (\d+) dollars in it$/ do |subdomain, amount|
  load_account(subdomain)
  current_account.entries.delete_all
  current_account.entries.create(:amount => Money.new(amount.to_i * 100))
end

Given /^the (.+) account should have less than (\d+) dollars in it$/ do |subdomain, amount|
  load_account(subdomain)
  assert current_account.balance < Money.new(amount.to_i * 100)
end

