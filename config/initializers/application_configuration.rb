ApplicationConfiguration = YAML.load_file(Rails.root.join('config', 'application.yml')).fetch(Rails.env).with_indifferent_access
