class Mailer < ActionMailer::Base
  # TODO extract a translate method for ActionMailer::Base that scopes translation keys and always raises
  def invitation_created(invitation)
    subject    I18n.t('mailer.invitation_created.subject', :raise => true)
    recipients invitation.email
    from       Application.email

    body       :body => I18n.t('mailer.invitation_created.body', :invitation_code => invitation.code, :raise => true),
               :url => new_account_url(:account => { :invitation_code => invitation.code })
  end

  # TODO use invitation.name as well as invitation.email to make it look nicer. (composed_of?)
end
