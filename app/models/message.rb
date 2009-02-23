class Message < ActiveRecord::Base
  validates_presence_of :recipient
  validates_format_of :recipient, :with => /^2557\d{8}$/

  validates_presence_of :text
  validates_length_of :text, :maximum => 160, :allow_blank => true

  belongs_to :user
  delegate :account, :to => :user

  after_create :deliver, :charge

  def cost
    Money.new(5)
  end

  private

  def charge
    account.charge_for(self)
  end

  def deliver
    MessageGateway.deliver(self)
  end
end
