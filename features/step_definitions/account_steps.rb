Then /^the (.+) account should have (\d+) dollars in it$/ do |subdomain, amount|
  assert_equal Money.dollars(amount.to_i), existing_account(subdomain).balance
end

Then /^the (.+) account should have less than (\d+) dollars in it$/ do |subdomain, amount|
  assert existing_account(subdomain).balance < Money.dollars(amount.to_i)
end

