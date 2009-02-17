class User < ActiveRecord::Base
  acts_as_authentic :scope => :account_id
  belongs_to :account
end
