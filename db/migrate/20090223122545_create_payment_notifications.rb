class CreatePaymentNotifications < ActiveRecord::Migration
  def self.up
    create_table :payment_notifications do |t|
      t.references :payment

      t.text :paypal_notification

      t.timestamps
    end
  end

  def self.down
    drop_table :payment_notifications
  end
end
