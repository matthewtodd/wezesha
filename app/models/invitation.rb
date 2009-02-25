class Invitation < ActiveRecord::Base
  validates_presence_of :email
  validates_email_veracity_of :email, :domain_check => false, :message => :invalid
  belongs_to :source, :polymorphic => true
  before_create :generate_code

  private

  CODE_LETTERS = ('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'9').to_a

  def generate_code
    self.code = (1..20).map { CODE_LETTERS.rand }.join
  end
end
