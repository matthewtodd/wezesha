module Admin::Subscribers
end

class Admin::Subscribers::InvitationsController < Admin::ApplicationController
  before_filter :load_subscriber
  before_filter :build_invitation, :only => [:create]

  def create
    if @invitation.save
      redirect_to admin_subscribers_path(:anchor => dom_id(@subscriber))
    else
      flash[:error] = @invitation.errors.full_messages.to_sentence
      redirect_to admin_subscribers_path
    end
  end

  private

  def load_subscriber
    @subscriber = Subscriber.find(params[:subscriber_id])
  end

  def build_invitation
    @invitation = @subscriber.invitations.build(params[:invitation])
  end
end
