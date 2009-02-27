class PaymentsController < ApplicationController
  before_filter :user_sign_in_required
  before_filter :build_payment, :only => :create

  def create
    if @payment.save
      redirect_to @payment.paypal_url(payment_notifications_url(@payment))
    else
      render :new
    end
  end

  private

  def build_payment
    @payment = current_user.payments.build(params[:payment])
  end
end
