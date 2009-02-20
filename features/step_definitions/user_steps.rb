def current_user
  @current_user ||= User.first
end

def load_user(email)
  @current_user = current_account.users.find_by_email!(email)
end

Given /^I am signed in to (.+) as (.+)$/ do |subdomain, email|
  load_account(subdomain)
  load_user(email)
  cookies['user_credentials'] = current_user.persistence_token
end
