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
    Rails.root.join('config', 'application.yml')
  end
end

Application = ApplicationConfiguration.new(Rails.env)