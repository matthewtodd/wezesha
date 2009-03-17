class Admin::ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password, :password_confirmation

  before_filter :set_locale
  before_filter :administrator_sign_in_required
  helper_method :current_administrator

  protected

  def current_administrator
    return @current_administrator if defined?(@current_administrator)
    @current_administrator = current_administrator_session && current_administrator_session.administrator
  end

  def current_administrator_session
    return @current_administrator_session if defined?(@current_administrator_session)
    @current_administrator_session = AdministratorSession.find
  end

  private

  def set_locale
    I18n.locale = params[:locale] if params[:locale]
  end

  def administrator_sign_in_required
    unless current_administrator
      respond_to do |format|
        format.html { render :text => interpret_status(:not_found), :status => :not_found }
        format.any  { render :nothing => true, :status => :unauthorized }
      end
    end
  end
end