# FIXME get rid of this?
def load_user(email)
  @current_user = existing_user(email)
end

Given /^I am signed in to (.+) as (.+)$/ do |subdomain, email|
  load_account(subdomain)
  load_user(email)
  cookies['user_credentials'] = current_user.persistence_token
end
