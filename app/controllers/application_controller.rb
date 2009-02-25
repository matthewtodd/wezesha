# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password, :password_confirmation

  before_filter :set_locale
  before_filter :load_account, :if => :current_subdomain
  helper_method :current_user

  protected

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = defined?(@account) && @account && @account.user_sessions.find
  end

  def redirect_back_or_to(location)
    redirect_to session.delete(:return_to) || location
  end

  private

  def load_account
    @account = Account.find_by_subdomain!(current_subdomain)
  end

  def set_locale
    I18n.locale = params[:locale] if params[:locale]
  end

  def store_location
    session[:return_to] = request.request_uri
  end

  def user_sign_in_required
    unless current_user
      respond_to do |format|
        format.html { store_location; flash[:error] = t('sign_in.required'); redirect_to new_user_session_path }
        format.any  { render :nothing => true, :status => :unauthorized }
      end
    end
  end
end
