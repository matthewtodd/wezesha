class Mobile < ActiveRecord::Base
  attr_readonly :number
  validates_presence_of :number
  validates_format_of :number, :with => /^2557\d{8}$/

  attr_accessor :verification_token
  attr_accessible :verification_token
  before_create :generate_verification_token
  before_update :validate_verification_token

  private

  TOKEN_CHARACTERS = ('A'..'Z').to_a
  def generate_verification_token
    self.token = Array.new(6) { TOKEN_CHARACTERS.rand }.join
  end

  def validate_verification_token
    if token.to_s.downcase == verification_token.to_s.downcase
      self.verified_at = Time.now
    end
  end
end
