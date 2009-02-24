require 'test_helper'

class Payment::NotificationTest < ActiveSupport::TestCase
  should_belong_to :payment

  def from_paypal_notification(parameters)
    defaults = {
      :mc_currency => 'USD',
      :mc_gross => @payment.amount.dollars,
      :receiver_email => Application[:paypal_account]
    }

    @payment.notifications.make_unsaved :paypal_notification => ActiveMerchant::Billing::Integrations::Paypal::Notification.new(defaults.merge(parameters).to_query)
  end

  context 'given a payment' do
    setup { @payment = Payment.make }

    context 'amount' do
      should 'be derived from mc_gross and mc_currency' do
        assert_equal Money.dollars(3), from_paypal_notification(:mc_gross => '3.00').amount
      end

      should 'invalidate notification if mc_currency is not USD' do
        assert !from_paypal_notification(:mc_currency => 'TZS').valid?
      end

      should 'not invalidate notification if mc_currency is USD' do
        assert from_paypal_notification(:mc_currency => 'USD').valid?
      end

      should 'invalidate notification if not equal to payment amount' do
        assert !from_paypal_notification(:mc_gross => @payment.amount.dollars - 1).valid?
      end

      should 'not invalidate notification if equal to payment amount' do
        assert from_paypal_notification(:mc_gross => @payment.amount.dollars).valid?
      end
    end

    context 'receiver_email' do
      should 'invalidate notification if different from paypal account' do
        assert !from_paypal_notification(:receiver_email => 'bob@example.com').valid?
      end

      should 'not invalidate notification if equal to paypal account' do
        assert from_paypal_notification(:receiver_email => Application[:paypal_account]).valid?
      end
    end
  end

end
