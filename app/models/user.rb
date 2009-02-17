class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation

  acts_as_authentic :scope => :account_id
  belongs_to :account
  has_one :mobile
  has_many :messages
end
