class Admin::SubscribersController < Admin::ApplicationController
  before_filter :load_subscriber, :only => [:destroy]

  def index
    @subscribers = Subscriber.all
  end

  def destroy
    @subscriber.destroy
    redirect_to admin_subscribers_path
  end

  private

  def load_subscriber
    @subscriber = Subscriber.find(params[:id])
  end
end
