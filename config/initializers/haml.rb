# Apparently you have to say this when Haml's a vendored gem but not installed
# outside this project.
Haml.init_rails(binding)

# Tell Haml to wrap html attributes with double instead of single quotes.
Haml::Template.options[:attr_wrapper] = '"'
