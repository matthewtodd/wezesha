class ApplicationConfiguration
  def initialize(environment)
    configuration(environment).each do |key, value|
      metaclass.send(:define_method, key) { value }
    end
  end

  private

  def configuration(environment)
    YAML.load_file(configuration_file).fetch(environment)
  end

  def configuration_file
    File.expand_path('../../application.yml', __FILE__)
  end
end

Application = ApplicationConfiguration.new(RAILS_ENV)
