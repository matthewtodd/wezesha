class SubscriptionsController < ApplicationController
  before_filter :build_subscription

  def create
    if @subscription.save
      flash[:notice] = t('new_subscription.thank_you')
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def build_subscription
    @subscription = Subscription.new(params[:subscription])
  end
end