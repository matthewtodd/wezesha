class Subscriber < ActiveRecord::Base
  default_scope :order => :created_at

  has_many :invitations, :as => :source, :dependent => :destroy, :extend => DefaultAssociationAttributes do
    def default_attributes
      { :email => proxy_owner.email }
    end
  end

  validates_presence_of :email
  validates_email_veracity_of :email, :domain_check => false, :message => :invalid
end
