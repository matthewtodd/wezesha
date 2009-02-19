class MessagesController < ApplicationController
  before_filter :user_sign_in_required
  before_filter :build_message, :only => [:new, :create]

  def create
    if @message.save
      respond_to do |format|
        format.html { redirect_to account_path }
        format.xml  { render :xml => @message, :status => :created, :location => message_path(@message, :format => :xml) }
      end
    else
      respond_to do |format|
        format.html { render :new }
        format.xml  { render :xml => @message.errors, :status => :unprocessable_entity }
      end
    end
  end

  private

  def build_message
    @message = current_user.messages.build(params[:message])
  end
end
