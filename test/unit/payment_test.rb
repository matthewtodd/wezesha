require 'test_helper'

class PaymentTest < ActiveSupport::TestCase
  should_not_allow_mass_assignment_of *any_attribute_other_than(:cents)

  should_belong_to :user
  should_allow_values_for :cents, '1'
  should_not_allow_values_for :cents, '1.1', 'not a number', '', nil, :message => :not_a_number
  should_not_allow_values_for :cents, '0', '-1', :message => default_error_message(:greater_than, :count => 0)

  context 'payment' do
    setup { @payment = Payment.make }

    context 'paypal_url parameters' do
      setup do
        query = URI.parse(@payment.paypal_url).query
        query = query.split('&').map { |pair| pair.split('=', 2) }.flatten.map { |value| URI.unescape(value) }
        @parameters = Hash[*query].with_indifferent_access
      end

      should 'use business from application configuration' do
        assert_equal Application.paypal_account, @parameters[:business]
      end

      should 'use amount from payment' do
        assert_equal @payment.amount.dollars.to_s, @parameters[:amount]
      end
    end
  end
end
