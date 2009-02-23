require 'sham'
require 'faker'

Sham.email         { Faker::Internet.email }
Sham.mobile_number { Faker.numerify('2557########') }
Sham.subdomain     { Faker::Internet.domain_word }

Account.blueprint do
  subdomain { Sham.subdomain }
end

User.blueprint do
  account
  email { Sham.email }
  password 'secret'
  password_confirmation 'secret'
end

Message.blueprint do
  user
  recipient { Sham.mobile_number }
  text { Faker::Lorem.sentence }
end
