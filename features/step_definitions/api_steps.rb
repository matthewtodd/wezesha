def http_basic_authentication_credentials(user = current_user)
  ActionController::HttpAuthentication::Basic.encode_credentials(user.single_access_token, 'X')
end

When /^I use the API (without my credentials )?to send a message to my phone number with text "(.*)"$/ do |unauthorized, text|
  data = { :recipient => my_phone_number, :text => text }.to_xml(:root => :message)

  headers = {}.tap do |headers|
    headers['Content-Type'] = 'application/xml'
    headers['Authorization'] = http_basic_authentication_credentials unless unauthorized
  end

  post messages_path(:subdomain => current_user.account.subdomain, :format => :xml), data, headers
end

Then /^I should receive an? (.+) (?:status|error)$/ do |message|
  assert_equal message, status_message
end
