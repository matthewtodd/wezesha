require 'sham'
require 'faker'

Sham.mobile_number { Faker.numerify('2557########') }

Message.blueprint do
  recipient { Sham.mobile_number }
  text { Faker::Lorem.sentence }
end

Mobile.blueprint do
  number { Sham.mobile_number }
end

class Mobile
  def self.make_verified(attributes = {})
    make(attributes).tap do |mobile|
      mobile.update_attribute(:verified_at, Time.now)
    end
  end
end