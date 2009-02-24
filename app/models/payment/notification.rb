class Payment::Notification < ActiveRecord::Base
  belongs_to :payment
  composed_of :paypal_notification, :class_name => 'ActiveMerchant::Billing::Integrations::Paypal::Notification', :mapping => %w(paypal_notification raw)
  delegate :account, :amount, :currency, :to => :paypal_notification

  validates_inclusion_of :account, :in => [Application[:paypal_account]]
  validates_inclusion_of :currency, :in => %w(USD)
  validate_on_create :amount_matches_payment_amount

  private

  # FIXME translate this error message
  def amount_matches_payment_amount
    unless amount == payment.amount
      errors.add(:amount, 'does not match payment amount')
    end
  end
end
