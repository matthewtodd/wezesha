# Apparently you have to say this when Haml's a vendored gem but not installed
# outside this project?
Haml.init_rails(binding)

# Tell Haml to wrap html attributes with double instead of single quotes.
Haml::Template.options[:attr_wrapper] = '"'

# Have Sass generate easy-to-read css files.
Sass::Plugin.options[:style] = :expanded

# Require that Sass attributes be followed by either a colon or an equals sign.
Sass::Plugin.options[:attribute_syntax] = :alternate

# Tell Sass where our stylesheets are.
Sass::Plugin.options[:template_location] = Rails.root.join('app', 'views', 'layouts').to_s
