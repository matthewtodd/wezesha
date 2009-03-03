class Account::Entry < ActiveRecord::Base
  attr_accessible :amount, :source
  belongs_to :account
  belongs_to :source, :polymorphic => true
  composed_of :amount, :class_name => 'Money', :mapping => %w(cents cents)
end
