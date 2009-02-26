class Subscriber < ActiveRecord::Base
  default_scope :order => :created_at

  has_many :invitations, :as => :source do
    def build(attributes = {}, &block)
      super((attributes || {}).symbolize_keys.reverse_merge(:email => proxy_owner.email), &block)
    end
  end

  validates_presence_of :email
  validates_email_veracity_of :email, :domain_check => false, :message => :invalid
end
