class Account < ActiveRecord::Base
  attr_accessible :subdomain, :users_attributes

  validates_presence_of :subdomain
  validates_uniqueness_of :subdomain
  validates_exclusion_of :subdomain, :in => ['admin', 'api', 'blog', 'developer', 'docs', 'example', 'gems', 'help', 'mail', 'pop', 'pop3', 'imap', 'sample', 'site', 'smtp', 'staging', 'stats', 'status', 'support', 'test', 'testing', 'www']
  validates_format_of :subdomain, :with => /^[a-z]+$/

  has_many :users
  accepts_nested_attributes_for :users
  authenticates_many :user_sessions
end
