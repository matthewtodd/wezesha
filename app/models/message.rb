class Message < ActiveRecord::Base
  validates_presence_of :text
  validates_length_of :text, :maximum => 160, :allow_blank => true

  belongs_to :user

  after_create { |message| MessageGateway.deliver(message) }
end
