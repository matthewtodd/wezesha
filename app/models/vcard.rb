require 'validates_as_tanzanian_mobile_number'

class Vcard < Message
  HEADER = '06050423F40000'

  attr_accessible :recipient, :name, :number
  attr_accessor :name, :number
  before_validation :generate_text
  validates_presence_of :name, :number
  validates_as_tanzanian_mobile_number :number

  def binary?
    true
  end

  # FIXME figure out if we need to calculate a different cost for sending vcards

  private

  def generate_text
    self.text = HEADER + vcard.unpack('H*').first
  end

  def vcard
    [].tap do |lines|
      lines << "BEGIN:VCARD"
      lines << "VERSION:2.1"
      lines << "N:#{self.name}"
      lines << "TEL;PREF:+#{self.number}"
      lines << "END:VCARD"
    end.map do |line|
      line + "\r\n"
    end.join
  end
end