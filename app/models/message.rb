class Message < ActiveRecord::Base
  validates_presence_of :recipient
  validates_format_of :recipient, :with => /^2557\d{8}$/

  validates_presence_of :text
  validates_length_of :text, :maximum => 160, :allow_blank => true

  belongs_to :user

  after_create { |message| MessageGateway.deliver(message) }
end
