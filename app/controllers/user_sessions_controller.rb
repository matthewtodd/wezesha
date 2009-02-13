class UserSessionsController < ApplicationController
  before_filter :load_account
  before_filter :build_user_session, :only => [:new, :create]

  def create
    if @user_session.save
      redirect_to account_path(:subdomain => @account.subdomain)
    else
      render :new
    end
  end

  private

  def load_account
    @account = Account.find_by_subdomain!(current_subdomain)
  end

  def build_user_session
    @user_session = @account.user_sessions.build(params[:user_session])
  end
end
