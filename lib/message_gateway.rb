module MessageGateway
  def self.implementation=(implementation_class)
    @@implementation = implementation_class.new
  end

  def self.deliver(message)
    @@implementation.deliver(message)
  end

  def self.messages
    @@implementation.messages
  end

  class BulkSMS
    require 'net/http'
    require 'uri'

    SERVICE_URI = URI.parse('http://bulksms.vsms.net:5567/eapi/submission/send_sms/2/2.0')

    def deliver(message)
      Net::HTTP.post_form(SERVICE_URI, :username => Application[:bulk_sms_username], :password => Application[:bulk_sms_password], :msisdn => message.recipient, :message => message.text, :dca => (message.binary? ? '8bit' : '7bit')).tap do |response|
        puts "BulkSMS response: #{response.body}"
      end
    end
  end

  class StandardOut
    def deliver(message)
      puts "Delivering Message to #{message.recipient}:"
      puts message.attributes.to_yaml
    end
  end

  class Test
    def deliver(message)
      messages << { :recipient => message.recipient, :message => message.text }
    end

    def messages
      @@messages ||= []
    end
  end
end