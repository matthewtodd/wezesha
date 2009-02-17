class MessageGateway
  def self.messages
    @@messages ||= []
  end

  def self.deliver(message)
    self.messages << { :message => message.text, :recipient => message.user.mobile.number }
  end
end