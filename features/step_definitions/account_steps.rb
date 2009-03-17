Given /^the (.+) account balance is (\d+) dollars$/ do |subdomain, amount|
  account = existing_account(subdomain)
  account.entries.create(:amount => (Money.dollars(amount.to_i) - account.balance))
end

Then /^the (.+) account balance should be (\d+) dollars$/ do |subdomain, amount|
  account = existing_account(subdomain)
  assert_equal Money.dollars(amount.to_i), account.balance
end

Then /^the (.+) account balance should be less than (\d+) dollars$/ do |subdomain, amount|
  account = existing_account(subdomain)
  assert account.balance < Money.dollars(amount.to_i)
end

