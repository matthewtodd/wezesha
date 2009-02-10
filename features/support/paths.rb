def path_to(page_name, subdomain=nil)
  options = {}
  options[:subdomain] = subdomain

  case page_name

  when /^home$/i
    root_path(options)

  when /^sign up$/i
    new_account_path(options)

  when /^sign up error$/i
    accounts_path(options)

  when /^sign in$/i
    new_session_path(options)

  else
    raise "Can't find mapping from \"#{page_name}\" to a path."
  end
end