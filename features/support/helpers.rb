def call_method(english)
  send(english.gsub(' ', '_'))
end

def some_phone_number
  @some_phone_number ||= Sham.mobile_number
end