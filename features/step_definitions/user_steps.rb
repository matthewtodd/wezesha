Given /^I am signed in to (.+) as (.+)$/ do |subdomain, email|
  @current_account = existing_account(subdomain)
  @current_user    = existing_user(email)
  cookies['user_credentials'] = current_user.persistence_token
end
