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

  private

  def load_account
    @account = Account.find_by_subdomain!(current_subdomain)
  end

  # def user_login_prohibited
  #
  # end

  def user_sign_in_required
    unless current_user
      respond_to do |format|
        format.html { flash[:error] = t('sign_in.required'); redirect_to new_user_session_path } # FIXME is it possible to set the flash and redirect together?
        format.any  { render :nothing => true, :status => :unauthorized }
      end
    end
  end

  def set_locale
    I18n.locale = params[:locale] if params[:locale]
  end
end
