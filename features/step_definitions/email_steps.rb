Then /^an email should be sent to "(.+)"$/ do |email_address|
  assert_sent_email { |message| message.to.include?(email_address) }
end

