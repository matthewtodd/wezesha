require 'validates_equality_of'

class Payment::Notification < ActiveRecord::Base
  attr_accessible :notification
  belongs_to  :payment
  delegate    :account, :amount, :to => :payment, :prefix => true
  composed_of :notification, :class_name => 'ActiveMerchant::Billing::Integrations::Paypal::Notification', :mapping => %w(notification raw)
  delegate    :account, :amount, :complete?, :currency, :to => :notification, :prefix => true

  before_validation :set_status

  # Make sure we've received a legitimate notification from Paypal.
  validates_equality_of :notification_account,  :with => Application[:paypal_account]
  validates_equality_of :notification_amount,   :with => :payment_amount
  validates_equality_of :notification_currency, :with => 'USD'

  # Make sure we don't record completed transactions twice.
  validates_uniqueness_of :status, :scope => :payment_id, :if => :notification_complete?

  # Credit the account.
  after_create :credit_account, :if => :notification_complete?

  private

  def credit_account
    payment_account.credit_for(self)
  end

  def set_status
    self.status = self.notification.status
  end
end
