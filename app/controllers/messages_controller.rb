class MessagesController < ApplicationController
  before_filter :user_sign_in_required
  before_filter :build_message, :only => [:new, :create]

  def create
    if @message.save
      redirect_to account_path
    else
      render :new
    end
  end

  private

  def build_message
    @message = current_user.messages.build(params[:message])
  end
end
