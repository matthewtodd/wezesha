class Subscription < ActiveRecord::Base
  validates_presence_of :email
  validates_email_veracity_of :email, :domain_check => false, :message => :invalid
  validates_uniqueness_of :email, :case_sensitive => false
end
