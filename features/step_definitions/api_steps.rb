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
