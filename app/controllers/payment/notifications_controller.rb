class Payment::NotificationsController < ApplicationController
  protect_from_forgery :except => [:create]

  before_filter :load_payment
  before_filter :build_paypal_notification
  before_filter :acknowledge_paypal_notification
  before_filter :build_payment_notification

  def create
    @payment_notification.save!
    render :nothing => true, :status => :created
  end

  private

  def load_payment
    @payment = @account.payments.find(params[:payment_id])
  end

  def build_paypal_notification
    @paypal_notification = ActiveMerchant::Billing::Integrations::Paypal::Notification.new(request.raw_post)
  end

  def acknowledge_paypal_notification
    render :nothing => true, :status => :unprocessable_entity unless @paypal_notification.acknowledge
  end

  def build_payment_notification
    @payment_notification = @payment.notifications.build(:notification => @paypal_notification)
  end
end
