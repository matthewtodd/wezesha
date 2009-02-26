class Admin::SubscribersController < Admin::ApplicationController
  before_filter :load_subscriber, :only => [:destroy]

  def index
    @subscribers = Subscriber.all

    respond_to do |format|
      format.html
      format.xml { render :xml => @subscribers.to_xml(:include => :invitations) }
    end
  end

  def destroy
    @subscriber.destroy

    respond_to do |format|
      format.html { redirect_to admin_subscribers_path }
      format.xml  { render :nothing => true }
    end
  end

  private

  def load_subscriber
    @subscriber = Subscriber.find(params[:id])
  end
end
