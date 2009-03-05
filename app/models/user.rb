class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation

  acts_as_authentic :scope => :account_id
  belongs_to :account
  has_many :text_messages
  has_many :vcards
  has_many :payments

  delegate :sufficient_balance_for?, :to => :account
end
