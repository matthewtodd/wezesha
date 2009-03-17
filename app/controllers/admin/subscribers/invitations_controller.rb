module Admin::Subscribers
end

class Admin::Subscribers::InvitationsController < Admin::ApplicationController
  before_filter :load_subscriber
  before_filter :build_invitation, :only => [:create]

  def create
    if @invitation.save
      respond_to do |format|
        format.xml { render :xml => @invitation.to_xml(:root => :invitation), :status => :created, :location => admin_subscriber_invitation_url(@subscriber, @invitation, :format => :xml) }
      end
    else
      respond_to do |format|
        format.xml { render :xml => @invitation.errors, :status => :unprocessable_entity }
      end
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
