require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  should_validate_presence_of :text
  should_ensure_length_at_most :text, 160
end
