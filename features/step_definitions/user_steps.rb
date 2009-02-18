def current_user
  @current_user ||= User.first
end

Given /^I am signed in to (.+) as (.+)$/ do |subdomain, email|
  account = Account.find_by_subdomain!(subdomain)
  @current_user = account.users.find_by_email!(email)
  cookies['user_credentials'] = @current_user.persistence_token
end

Given /^I have configured my phone number$/ do
  current_user.mobile = Mobile.make_verified
end

Then /^I should receive "(.+)" on my phone$/ do |message|
  assert_contains MessageGateway.messages, :message => message, :recipient => current_user.mobile.number
end

Then /^I should not receive "(.+)" on my phone$/ do |message|
  assert_does_not_contain MessageGateway.messages, :message => message, :recipient => current_user.mobile.number
end