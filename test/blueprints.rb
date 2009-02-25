require 'sham'
require 'faker'

Sham.email         { Faker::Internet.email }
Sham.mobile_number { Faker.numerify('2557########') }
Sham.subdomain     { Faker::Internet.domain_word }

Subscription.blueprint do
  email { Sham.email }
end

Invitation.blueprint do
  email { Sham.email }
end

Account.blueprint do
  invitation
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

Payment.blueprint do
  user
  amount { Money.dollars(5) }
end

Payment::Notification.blueprint do
  payment
end
