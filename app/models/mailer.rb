class Mailer < ActionMailer::Base
  # TODO extract a translate method for ActionMailer::Base that scopes translation keys and always raises
  def invitation_created(invitation)
    subject    I18n.t('mailer.invitation_created.subject', :raise => true)
    recipients invitation.email
    from       Application[:email]

    body       :body => I18n.t('mailer.invitation_created.body', :raise => true),
               :url => new_account_url(:account => { :invitation_code => invitation.code })
  end
end
