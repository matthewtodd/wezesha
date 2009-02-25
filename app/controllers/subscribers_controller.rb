class SubscribersController < ApplicationController
  before_filter :build_subscriber

  def create
    if @subscriber.save
      flash[:notice] = t('new_subscriber.thank_you')
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def build_subscriber
    @subscriber = Subscriber.new(params[:subscriber])
  end
end