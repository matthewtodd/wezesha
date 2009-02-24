require 'test_helper'

class Payment::NotificationTest < ActiveSupport::TestCase
  should_belong_to :payment

  def from_paypal_notification(parameters)
    defaults = {
      :mc_currency => 'USD',
      :mc_gross => @payment.amount.dollars,
      :payment_status => 'Pending',
      :receiver_email => Application[:paypal_account]
    }

    @payment.notifications.make_unsaved :notification => ActiveMerchant::Billing::Integrations::Paypal::Notification.new(defaults.merge(parameters).to_query)
  end

  context 'given a payment' do
    setup { @payment = Payment.make }

    context 'notification_account' do
      should 'invalidate notification if different from paypal account' do
        assert !from_paypal_notification(:receiver_email => 'bob@example.com').valid?
      end

      should 'not invalidate notification if equal to paypal account' do
        notification = from_paypal_notification(:receiver_email => Application[:paypal_account])
        notification.valid?
        assert_equal [], notification.errors.full_messages
      end
    end

    context 'notification_amount' do
      should 'be derived from mc_gross' do
        assert_equal Money.dollars(3), from_paypal_notification(:mc_gross => '3.00').notification_amount
      end

      should 'invalidate notification if not equal to payment amount' do
        assert !from_paypal_notification(:mc_gross => @payment.amount.dollars - 1).valid?
      end

      should 'not invalidate notification if equal to payment amount' do
        notification = from_paypal_notification(:mc_gross => @payment.amount.dollars)
        notification.valid?
        assert_equal [], notification.errors.full_messages
      end
    end

    context 'notification_currency' do
      should 'invalidate notification if mc_currency is not USD' do
        assert !from_paypal_notification(:mc_currency => 'TZS').valid?
      end

      should 'not invalidate notification if mc_currency is USD' do
        notification = from_paypal_notification(:mc_currency => 'USD')
        notification.valid?
        assert_equal [], notification.errors.full_messages
      end
    end

    # FIXME should allow multiple Pending statuses
    context 'notification_status' do
      should 'not invalidate notification when first set to Completed' do
        notification = from_paypal_notification(:payment_status => 'Completed')
        notification.valid?
        assert_equal [], notification.errors.full_messages
      end

      should 'not invalidate notification when repeatedly set to Pending' do
        from_paypal_notification(:payment_status => 'Pending').save!
        notification = from_paypal_notification(:payment_status => 'Pending')
        notification.valid?
        assert_equal [], notification.errors.full_messages
      end

      should 'invalidate notification if a Completed notification has already been received' do
        from_paypal_notification(:payment_status => 'Completed').save!
        assert !from_paypal_notification(:payment_status => 'Completed').valid?
      end
    end
  end
end
