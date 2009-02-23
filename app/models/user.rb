class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation

  acts_as_authentic :scope => :account_id
  belongs_to :account
  has_many :messages
  has_many :payments
end
