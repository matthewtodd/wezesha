def api(method, path, data, user=current_administrator)
  headers = {}
  headers['Content-Type']  = 'application/xml'
  headers['Authorization'] = http_basic_authentication_credentials(user) unless user.nil?
  send(method, path, data, headers)
end

When /^I use the Admin API to credit (.+) (\d+) dollars$/ do |subdomain, amount|
  path = admin_account_entries_path(existing_account(subdomain), :format => :xml)
  data = { :cents => Money.dollars(amount.to_i).cents }.to_xml(:root => :entry)
  api :post, path, data
end

When /^I use the Admin API to delete (.+) "(.+)"$/ do |finder, parameter|
  path = polymorphic_url([:admin, call_method(finder, parameter)], :format => :xml)
  api :delete, path, ''
end

When /^I use the Admin API to invite existing subscriber "(.+)"$/ do |email|
  path = admin_subscriber_invitations_path(existing_subscriber(email), :format => :xml)
  api :post, path, ''
end

When /^I use the API (without my credentials )?to send "(.*)" to (.+)$/ do |unauthorized, text, phone_number_method|
  path = text_messages_path(:subdomain => current_user.account.subdomain, :format => :xml)
  data = { :recipient => call_method(phone_number_method), :text => text }.to_xml(:root => :text_message)
  api :post, path, data, (unauthorized ? nil : current_user)
end

Then /^I should receive an? (.+) (?:status|error)$/ do |message|
  assert_equal message, status_message, response.body
end
