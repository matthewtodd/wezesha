class Account::Entry < ActiveRecord::Base
  belongs_to :source, :polymorphic => true
  composed_of :amount, :class_name => 'Money', :mapping => %w(cents cents)
end
