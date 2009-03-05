class Mailer < ActionMailer::Base
  def invitation_created(invitation)
    subject    t(:subject)
    recipients invitation.email
    from       Application.email
    body       :body => t(:body, :invitation_code => invitation.code), :url => new_account_url(:account => { :invitation_code => invitation.code })
  end

  private

  def translate(key, options = {})
    I18n.translate(key, options.merge(:raise => true, :scope => [mailer_name, template]))
  end
  alias_method :t, :translate
end
