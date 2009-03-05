def call_method(english, *args)
  send(english.downcase.gsub(' ', '_'), *args)
end

def current_account
  @current_account ||= Account.first
end

def current_administrator
  @current_administrator ||= Administrator.first
end

def current_payment(reload = false)
  if reload
    @current_payment = current_user.payments.reload.last
  else
    @current_payment ||= current_user.payments.last
  end
end

def current_user
  @current_user ||= User.first
end

def existing_account(subdomain)
  Account.find_by_subdomain!(subdomain)
end

def existing_subscriber(email)
  Subscriber.find_by_email!(email)
end

def existing_user(email)
  current_account.users.find_by_email!(email)
end

def http_basic_authentication_credentials(user = current_user)
  ActionController::HttpAuthentication::Basic.encode_credentials(user.single_access_token, 'X')
end

def optionally_within_record(finder, parameter)
  if finder
    within_record(call_method(finder, parameter)) { yield }
  else
    yield
  end
end

def paypal_notification(payment)
  ActiveMerchant::Billing::Integrations::Paypal::Notification.new(paypal_notification_parameters(payment).to_query)
end

def paypal_notification_parameters(payment)
  {
    :business => Application.paypal_account,
    :mc_currency => 'USD',
    :mc_gross => payment.amount.dollars,
    :payment_status => 'Completed',
  }
end

def some_phone_number
  @some_phone_number ||= Sham.mobile_number
end

def within_record(record)
  record_dom_id = ActionController::RecordIdentifier.dom_id(record)
  within("##{record_dom_id}") { yield }
end