Application = YAML.load(ERB.new(IO.read(Rails.root.join('config', 'application.yml'))).result).fetch(Rails.env).symbolize_keys
