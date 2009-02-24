class PaymentNotificationsController < ApplicationController
  before_filter :load_payment
  before_filter :build_paypal_notification
  before_filter :acknowledge_paypal_notification
  before_filter :build_payment_notification

  def create
    if @payment_notification.save

    else

    end
  end

  private

  def load_payment
    @account.payments.find(params[:id])
  end

  def build_paypal_notification
    @paypal_notification = ActiveMerchant::Billing::Integrations::Paypal::Notification.new(request.raw_post)
  end

  def acknowledge_paypal_notification
    @paypal_notification.acknowledge
  end

  def build_payment_notification
    @payment_notification = @payment.notifications.build(:paypal_notification => @paypal_notification)
  end
end
