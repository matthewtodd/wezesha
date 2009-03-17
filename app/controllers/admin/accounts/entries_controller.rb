module Admin::Accounts
end

class Admin::Accounts::EntriesController < Admin::ApplicationController
  before_filter :load_account
  before_filter :build_entry, :only => [:create]

  def create
    if @entry.save
      respond_to do |format|
        format.xml { render :xml => @entry.to_xml(:root => :entry), :status => :created, :location => admin_account_entry_url(@account, @entry, :format => :xml) }
      end
    else
      respond_to do |format|
        format.xml { render :xml => @entry.errors, :status => :unprocessable_entity }
      end
    end
  end

  private

  def load_account
    @account = Account.find(params[:account_id])
  end

  def build_entry
    @entry = @account.entries.build(params[:entry])
  end
end
