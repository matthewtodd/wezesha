Given /^I am signed in to (.+) as (.+)$/ do |subdomain, email|
  account = Account.find_by_subdomain!(subdomain)
  user = account.users.find_by_email!(email)
  cookies['user_credentials'] = user.persistence_token
end