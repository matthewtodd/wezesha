class Account < ActiveRecord::Base
  validates_uniqueness_of :subdomain

  has_many :users
  accepts_nested_attributes_for :users

  authenticates_many :sessions
end
