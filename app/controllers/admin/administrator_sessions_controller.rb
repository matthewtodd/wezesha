class Admin::AdministratorSessionsController < Admin::ApplicationController
  before_filter :build_administrator_session,    :only => [:new, :create]
  before_filter :administrator_sign_in_required, :only => [:destroy]

  def create
    if @administrator_session.save
      redirect_back_or_to admin_root_path
    else
      render :new
    end
  end

  def destroy
    current_administrator_session.destroy
    redirect_to new_admin_administrator_session_path
  end

  private

  def build_administrator_session
    @administrator_session = AdministratorSession.new(params[:administrator_session])
  end
end
