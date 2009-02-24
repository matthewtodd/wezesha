Application = YAML.load_file(Rails.root.join('config', 'application.yml')).fetch(Rails.env).symbolize_keys
