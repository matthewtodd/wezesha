class Account < ActiveRecord::Base
  validates_presence_of :subdomain
  validates_uniqueness_of :subdomain
  validates_exclusion_of :subdomain, :in => ['admin', 'api', 'blog', 'developer', 'docs', 'example', 'gems', 'help', 'mail', 'pop', 'pop3', 'imap', 'sample', 'site', 'smtp', 'staging', 'stats', 'status', 'support', 'test', 'testing', 'www']

  has_many :users
  accepts_nested_attributes_for :users

  authenticates_many :sessions
end
