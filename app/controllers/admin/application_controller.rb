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

  def redirect_back_or_to(location)
    redirect_to session.delete(:return_to) || location
  end

  private

  def set_locale
    I18n.locale = params[:locale] if params[:locale]
  end

  def store_location
    session[:return_to] = request.request_uri
  end

  def administrator_sign_in_required
    unless current_administrator
      respond_to do |format|
        format.html { store_location; flash[:error] = t('admin.administrator_sessions.new.required'); redirect_to new_admin_administrator_session_path }
        format.any  { render :nothing => true, :status => :unauthorized }
      end
    end
  end
end