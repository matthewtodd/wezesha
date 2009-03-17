require 'test_helper'

class MoneyTest < ActiveSupport::TestCase
  should 'negated' do
    assert_equal Money.new(-3), Money.new(3).negated
  end

  should 'to_s' do
    assert_equal '10.00', Money.dollars(10).to_s
    assert_equal '-10.00', Money.dollars(10).negated.to_s
  end

  should 'subtract' do
    assert_equal Money.dollars(4), Money.dollars(10) - Money.dollars(6)
  end
end
