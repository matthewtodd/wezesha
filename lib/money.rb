class Money
  def self.cents(cents)
    new(cents)
  end

  def self.dollars(dollars)
    new(dollars * 100)
  end

  include Comparable

  def <=>(other)
    cents <=> other.cents
  end

  def cents
    @cents
  end

  def dollars
    @cents / 100.0
  end

  def negated
    self.class.cents(-cents)
  end

  private

  def initialize(cents)
    @cents = cents
  end
end