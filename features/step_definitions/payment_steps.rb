When /^I submit the PayPal form$/ do
  assert_redirected_to Payment.last.paypal_url
end

