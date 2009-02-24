require 'validates_as_tanzanian_mobile_number'

class Message < ActiveRecord::Base
  validates_presence_of :recipient
  validates_as_tanzanian_mobile_number :recipient

  validates_presence_of :text
  validates_length_of :text, :maximum => 160, :allow_blank => true, :unless => :binary?
  validates_length_of :text, :maximum => 280, :allow_blank => true, :if => :binary?

  belongs_to :user
  delegate :account, :to => :user

  after_create :deliver, :charge_account

  def binary?
    false
  end

  def cost
    Money.new(5)
  end

  private

  def charge_account
    account.charge_for(self)
  end

  def deliver
    MessageGateway.deliver(self)
  end
end
