def current_account
  @current_account ||= Account.first
end

def load_account(subdomain)
  @current_account = Account.find_by_subdomain!(subdomain)
end

Given /^the (.+) account has (\d+) dollars in it$/ do |subdomain, amount|
  load_account(subdomain)
  current_account.entries.delete_all
  current_account.entries.create(:amount => amount.to_i)
end

Given /^the (.+) account should have less than (\d+) dollars in it$/ do |subdomain, amount|
  load_account(subdomain)
  assert current_account.balance < amount.to_i
end

