def paypal_notification_parameters(payment)
  {
    :business => Application[:paypal_account],
    :mc_currency => 'USD',
    :mc_gross => payment.amount.dollars,
    :payment_status => 'Completed',
  }
end

When /^I submit the PayPal form$/ do
  @payment = Payment.last
  assert_redirected_to @payment.paypal_url(payment_notifications_url(@payment))
end

When /Paypal( incorrectly)? notifies the site about my( unacknowledged)? payment/ do |incorrect, unacknowledged|
  ActiveMerchant::Billing::Integrations::Paypal::Notification.any_instance.stubs(:acknowledge).returns(unacknowledged.nil?)

  url    = payment_notifications_url(@payment)
  params = paypal_notification_parameters(@payment).tap { |params| params.merge!(:mc_gross => '0.00') if incorrect }
  post url, params
  assert_response((incorrect || unacknowledged) ? :unprocessable_entity : :created)
end
