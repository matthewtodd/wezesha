require 'sham'
require 'faker'

Sham.mobile_number { Faker.numerify('2557########') }

Account.blueprint do
  subdomain { Faker::Internet.domain_word }
end

Message.blueprint do
  recipient { Sham.mobile_number }
  text      { Faker::Lorem.sentence }
end
