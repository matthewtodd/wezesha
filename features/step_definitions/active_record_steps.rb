Then /^(.*?) "(.*?)" should have (\d+) (.*?)$/ do |finder, parameter, count, association|
  assert_equal count.to_i, call_method(finder, parameter).send(association.downcase.pluralize).count
end
