class Admin::SubscribersController < Admin::ApplicationController
  def index
    @subscribers = Subscriber.all
  end
end
