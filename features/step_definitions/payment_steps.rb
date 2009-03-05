Given /^I have made a payment for (\d+) dollars$/ do |amount|
  payment = current_user.payments.make(:amount => Money.dollars(amount.to_i))
  payment.notifications.make(:notification => paypal_notification(payment))
end

Given /^I have not made any payments$/ do
end

When /^I submit the PayPal form$/ do
  payment = current_payment(:reload)
  assert_redirected_to payment.paypal_url(payment_notifications_url(payment))
end

When /Paypal( incorrectly)? notifies the site about my( unacknowledged)? payment/ do |incorrect, unacknowledged|
  ActiveMerchant::Billing::Integrations::Paypal::Notification.any_instance.stubs(:acknowledge).returns(unacknowledged.nil?)

  url    = payment_notifications_url(current_payment)
  params = paypal_notification_parameters(current_payment).tap { |params| params.merge!(:mc_gross => '0.00') if incorrect }
  post url, params
  assert_response((incorrect || unacknowledged) ? :unprocessable_entity : :created, response.body)
end
