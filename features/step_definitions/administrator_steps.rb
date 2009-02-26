Given /^I am signed in as an administrator$/ do
  cookies['administrator_credentials'] = current_administrator.persistence_token
end
