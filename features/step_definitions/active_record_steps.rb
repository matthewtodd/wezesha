def assert_has_many_association_count(finder, parameter, association, count)
  assert_equal count.to_i, call_method(finder, parameter).send(association.downcase.pluralize).count
end

Given /^(.*?) "(.*?)" has (\d+) (.*?)$/ do |finder, parameter, count, association|
  assert_has_many_association_count(finder, parameter, association, count)
end

Then /^(.*?) "(.*?)" should have (\d+) (.*?)$/ do |finder, parameter, count, association|
  assert_has_many_association_count(finder, parameter, association, count)
end

Then /^(.*?) "(.*?)" should no longer exist$/ do |finder, parameter|
  assert_raise(ActiveRecord::RecordNotFound) { call_method(finder, parameter) }
end
