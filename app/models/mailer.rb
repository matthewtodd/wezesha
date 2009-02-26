class Mailer < ActionMailer::Base
  def invitation_created(invitation)
    subject    I18n.t('mailer.invitation.created.subject', :raise => true)
    recipients invitation.email
    from       Application[:email]

    body       :body => I18n.t('mailer.invitation.created.body', :raise => true),
               :url => new_account_url(:account => { :invitation_code => invitation.code })
  end
end
