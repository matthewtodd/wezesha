class Account::Entry < ActiveRecord::Base
  composed_of :amount, :class_name => 'Money'
end
