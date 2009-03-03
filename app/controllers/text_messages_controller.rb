class TextMessagesController < ApplicationController
  before_filter :user_sign_in_required
  before_filter :build_text_message, :only => [:new, :create]

  def create
    if @text_message.save
      respond_to do |format|
        format.html { redirect_to account_path }
        format.xml  { render :xml => @text_message, :status => :created, :location => text_message_path(@text_message, :format => :xml) }
      end
    else
      respond_to do |format|
        format.html { render :new }
        format.xml  { render :xml => @text_message.errors, :status => :unprocessable_entity }
      end
    end
  end

  private

  def build_text_message
    @text_message = current_user.text_messages.build(params[:text_message])
  end
end
