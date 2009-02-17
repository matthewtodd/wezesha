require 'test_helper'

class MobileTest < ActiveSupport::TestCase
  should_have_readonly_attributes :number
  should_not_allow_mass_assignment_of *any_attribute_other_than(:verification_token)

  # TODO should mobile numbers be unique? at what scope?
  should_validate_presence_of :number
  should_allow_values_for :number, '255712345678'
  should_not_allow_values_for :number, '254123456789', '255123', 'not numbers'

  context 'a newly created mobile' do
    setup { @mobile = Mobile.make }

    should 'have a simple token for future verification' do
      assert_match(/^[A-Z]{6}$/, @mobile.token)
    end

    context 'updated with the proper verfication token' do
      setup { @mobile.update_attributes(:verification_token => @mobile.token) }
      should_change '@mobile.verified_at', :from => nil
    end

    context 'updated with the lowercase version of the proper verfication token' do
      setup { @mobile.update_attributes(:verification_token => @mobile.token.downcase) }
      should_change '@mobile.verified_at', :from => nil
    end

    context 'updated with the wrong verfication token' do
      setup { @mobile.update_attributes(:verification_token => 'THERE IS NO WAY THIS IS THE TOKEN') }
      should_not_change '@mobile.verified_at'
    end
  end

  context 'creating a mobile with a verification token attribute' do
    setup { @mobile = Mobile.make(:verification_token => nil) }
    should 'not verifiy the mobile' do
      assert_nil @mobile.verified_at
    end
  end
end
