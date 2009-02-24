def paypal_notification_parameters
  {
    :business => '',
    :item_name => '',
    :receiver_email => '',
    # :invoice => '', # FIXME shall we pass through an invoice?
    :mc_currency => 'USD',
    :mc_gross => '',
    :payment_date => '', # HH:MM:SS DD Mmm YY, YYYY PST
    :payment_status => '',
    :txn_id => ''
  }
end

When /^I submit the PayPal form$/ do
  @payment = Payment.last
  assert_redirected_to @payment.paypal_url(payment_notifications_url(@payment))
end

When /Paypal later notifies the site about my payment/ do
  post(payment_notifications_url(@payment), paypal_notification_parameters)
end
