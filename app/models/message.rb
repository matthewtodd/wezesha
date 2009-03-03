require 'validates_as_tanzanian_mobile_number'

class Message < ActiveRecord::Base
  attr_accessible :recipient

  validate_on_create :account_balance_sufficient?
  validates_presence_of :recipient
  validates_as_tanzanian_mobile_number :recipient
  belongs_to :user
  delegate :account, :sufficient_balance_for?, :to => :user
  after_create :deliver, :charge_account

  private

  def account_balance_sufficient?
    errors.add_to_base(:insufficient_balance) unless sufficient_balance_for?(self)
  end

  def charge_account
    account.charge_for(self)
  end

  def deliver
    MessageGateway.deliver(self)
  end
end
