class Administrator < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation
  acts_as_authentic
end
