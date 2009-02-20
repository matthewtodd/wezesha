Then /^the message "(.*)" should be delivered to (.+)$/ do |message, phone_number_method|
  assert_contains MessageGateway.messages, { :message => message, :recipient => call_method(phone_number_method) }
end

