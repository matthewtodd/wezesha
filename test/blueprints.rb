require 'sham'
require 'faker'

Sham.mobile_number { Faker.numerify('2557########') }

Mobile.blueprint do
  number { Sham.mobile_number }
end

class Mobile
  def self.make_verified(attributes = {})
    make(attributes).tap do |mobile|
      mobile.update_attributes(:verification_token => mobile.token)
    end
  end
end
