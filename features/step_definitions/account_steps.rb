Given /^these accounts$/ do |accounts_table|
  accounts_table.hashes.each do |attributes|
    attributes = attributes.with_indifferent_access
    Account.new(:subdomain => attributes.delete(:subdomain)).tap do |account|
      account.users.build(attributes.reverse_merge(:password_confirmation => attributes[:password]))
    end.save!
  end
end