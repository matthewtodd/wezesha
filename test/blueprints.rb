require 'sham'
require 'faker'

Sham.email         { Faker::Internet.email }
Sham.mobile_number { Faker.numerify('2557########') }
Sham.name          { Faker::Name.name }
Sham.subdomain     { Faker::Internet.domain_word }

Subscriber.blueprint do
  email { Sham.email }
end

Invitation.blueprint do
  email { Sham.email }
end

Account.blueprint do
  invitation
  subdomain { Sham.subdomain }
end

Account::Entry.blueprint do
  account
end

Account::Entry.blueprint(:credit) do
  amount { Money.dollars(1) }
end

User.blueprint do
  account
  email { Sham.email }
  password 'secret'
  password_confirmation 'secret'
end

Message.blueprint do
  user { User.make(:account => Account.make { |account| account.entries.make(:credit) }) }
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

Vcard.blueprint do
  user { User.make(:account => Account.make { |account| account.entries.make(:credit) }) }
  recipient { Sham.mobile_number }
  name { Sham.name }
  number { Sham.mobile_number }
end