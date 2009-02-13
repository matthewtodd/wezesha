class AccountsController < ApplicationController
  before_filter :build_account, :only => [:new, :create]
  before_filter :load_account, :only => [:show, :edit, :update, :destroy]

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

  def load_account
    @account = Account.find_by_subdomain!(current_subdomain)
  end
end
