Given /^someone has already signed up with Invitation Code "(.+)"$/i do |code|
  Account.make(:invitation_code => code)
end
