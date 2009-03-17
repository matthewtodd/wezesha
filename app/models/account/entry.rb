class Account::Entry < ActiveRecord::Base
  attr_accessible :amount, :cents, :source
  belongs_to :account
  belongs_to :source, :polymorphic => true
  composed_of :amount, :class_name => 'Money', :mapping => %w(cents cents)
  validates_presence_of :cents
  validates_numericality_of :cents
end
