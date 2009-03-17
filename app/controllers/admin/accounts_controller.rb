class Admin::AccountsController < Admin::ApplicationController
  def index
    @accounts = Account.all
    respond_to do |format|
      format.xml { render :xml => @accounts.to_xml(:include => :entries) }
    end
  end
end