module DefaultAttributes
  def build_record(attrs, &block)
    super(with_default_attributes(attrs), &block)
  end

  def create_record(attrs, &block)
    super(with_default_attributes(attrs), &block)
  end

  def with_default_attributes(attrs)
    default_attributes.merge((attrs || {}).symbolize_keys)
  end
end

class Subscriber < ActiveRecord::Base
  default_scope :order => :created_at

  has_many :invitations, :as => :source, :dependent => :destroy, :extend => DefaultAttributes do
    def default_attributes
      { :email => proxy_owner.email }
    end
  end

  validates_presence_of :email
  validates_email_veracity_of :email, :domain_check => false, :message => :invalid
end
