class Subscriber < ActiveRecord::Base
  validates_presence_of :email
  validates_email_veracity_of :email, :domain_check => false, :message => :invalid
end
