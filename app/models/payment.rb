class Payment < ActiveRecord::Base
  attr_accessible :cents

  belongs_to  :user
  composed_of :amount, :class_name => 'Money', :mapping => %w(cents cents)
  delegate :account, :to => :user
  has_many :notifications

  validates_numericality_of :cents, :only_integer => true, :greater_than => 0

  def paypal_url(notify_url = nil)
    Application.paypal_url + '?' + paypal_parameters.merge(:notify_url => notify_url).to_query
  end

  private

  def paypal_parameters
    {
      :amount => self.amount.dollars,
      :business => Application.paypal_account,
      :cmd => '_xclick',
      :currency_code => 'USD',
      :item_name => I18n.translate(:item_name, :raise => true, :scope => 'activerecord.attributes.payment'),
      :no_note => 1,
      :no_shipping => 1,
      :rm => 1
    }
  end
end
