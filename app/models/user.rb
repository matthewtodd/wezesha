class User < ActiveRecord::Base
  acts_as_authentic :session_class => '::Session', :scope => :account_id
end
