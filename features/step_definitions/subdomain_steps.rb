Given /^I am on the (.+) page for (.+)$/ do |page_name, subdomain|
  visit path_to(page_name, :subdomain => subdomain)
end

When /^I go to the (.+) page for (.+)$/ do |page_name, subdomain|
  visit path_to(page_name, :subdomain => subdomain)
end
