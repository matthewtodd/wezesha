require 'test_helper'

class MoneyTest < ActiveSupport::TestCase
  should 'negated' do
    assert_equal Money.new(-3), Money.new(3).negated
  end
end
