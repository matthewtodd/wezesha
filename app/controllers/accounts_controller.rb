class AccountsController < ApplicationController
  before_filter :build_account,         :only => [:new, :create]
  before_filter :user_sign_in_required, :except => [:new, :create]

  def create
    if @account.save
      redirect_to new_user_session_path(:subdomain => @account.subdomain)
    else
      render :new
    end
  end

  private

  def build_account
    @account = Account.new(params[:account])
  end
end
