def path_to(page_name, options = {})
  case page_name

  # Top-level site
  when /^home$/i
    root_path(options)

  when /^sign up$/i
    new_account_path(options)

  # Administrative section
  when /^administrative sign in$/i
    new_admin_administrator_session_path(options)

  when /^administrative subscribers$/i
    admin_subscribers_path(options)

  # Subdomains
  when /^sign in$/i
    new_user_session_path(options)

  when /^account$/i
    account_path(options)

  when /^new message$/i
    new_message_path(options)

  else
    raise "Can't find mapping from \"#{page_name}\" to a path."
  end
end