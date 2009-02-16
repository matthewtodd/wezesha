Given /^these accounts$/ do |accounts_table|
  accounts_table.hashes.each do |attributes|
    attributes = attributes.with_indifferent_access
    Account.new(:subdomain => attributes.delete(:subdomain)).tap do |account|
      account.users.build(attributes.reverse_merge(:password_confirmation => attributes[:password]))
    end.save!
  end
end

Given /^I have not signed in$/ do
  # noop?
end

Given /^I am signed in to (.+) as (.+)$/ do |subdomain, email|
  account = Account.find_by_subdomain!(subdomain)
  user = account.users.find_by_email!(email)
  cookies['user_credentials'] = user.persistence_token
end