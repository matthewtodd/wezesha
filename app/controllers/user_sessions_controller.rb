class UserSessionsController < ApplicationController
  before_filter :build_user_session,    :only => [:new, :create]
  before_filter :user_sign_in_required, :only => [:destroy]

  def create
    if @user_session.save
      redirect_to account_path(:subdomain => @account.subdomain)
    else
      render :new
    end
  end

  def destroy
    current_user_session.destroy
    redirect_to new_user_session_path
  end

  private

  def build_user_session
    @user_session = @account.user_sessions.build(params[:user_session])
  end
end
