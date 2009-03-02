require 'rubygems'
require 'test/unit'
require 'shoulda'
require 'mocha'
require 'active_record'
require File.join(File.dirname(__FILE__), '..', 'lib', 'default_association_attributes.rb')

ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => ':memory:')

ActiveRecord::Base.connection.create_table :subscribers, :force => true do |table|
  table.string :email
end

ActiveRecord::Base.connection.create_table :invitations, :force => true do |table|
  table.references :source, :polymorphic => true
  table.string :email
end

class Subscriber < ActiveRecord::Base
  has_many :invitations, :as => :source, :extend => DefaultAssociationAttributes do
    def default_attributes
      { :email => proxy_owner.email }
    end
  end
end

class Invitation < ActiveRecord::Base
end