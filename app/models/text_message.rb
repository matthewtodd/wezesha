class TextMessage < Message
  attr_accessible :text
  validates_presence_of :text
  validates_length_of :text, :maximum => 160

  def binary?
    false
  end

  def cost
    Money.new(5)
  end
end
