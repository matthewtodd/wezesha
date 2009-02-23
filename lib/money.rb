class Money
  attr_reader :amount

  def initialize(amount)
    @amount = amount
  end

  def negated
    self.class.new(-amount)
  end

  include Comparable
  def <=>(other)
    amount <=> other.amount
  end
end