When /^I use the Admin API to credit (.+) (\d+) dollars$/ do |subdomain, amount|
  data = { :cents => Money.dollars(amount.to_i).cents }.to_xml(:root => :entry)

  headers = {}.tap do |headers|
    headers['Content-Type'] = 'application/xml'
    headers['Authorization'] = http_basic_authentication_credentials(current_administrator)
  end

  post admin_account_entries_path(existing_account(subdomain), :format => :xml), data, headers
end

When /^I use the API (without my credentials )?to send "(.*)" to (.+)$/ do |unauthorized, text, phone_number_method|
  data = { :recipient => call_method(phone_number_method), :text => text }.to_xml(:root => :text_message)

  headers = {}.tap do |headers|
    headers['Content-Type'] = 'application/xml'
    headers['Authorization'] = http_basic_authentication_credentials unless unauthorized
  end

  post text_messages_path(:subdomain => current_user.account.subdomain, :format => :xml), data, headers
end

Then /^I should receive an? (.+) (?:status|error)$/ do |message|
  assert_equal message, status_message
end
