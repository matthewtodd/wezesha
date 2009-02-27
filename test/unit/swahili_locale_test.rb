require 'test_helper'

class SwahiliLocaleTest < ActiveSupport::TestCase
  EN = YAML.load_file(Rails.root.join('config', 'locales', 'en.yml')).fetch('en')
  SW = YAML.load_file(Rails.root.join('config', 'locales', 'sw.yml')).fetch('sw')

  def self.should_have_the_same_structure_as(expected, actual, prefix=nil)
    expected.each do |key, value|
      should("have a translation for #{prefix}#{key}") { assert !actual[key].blank?, "translation missing: #{prefix}#{key}" }
      should_have_the_same_structure_as(expected[key], actual[key], "#{prefix}#{key}.") if value.is_a?(Hash) && actual.has_key?(key)
    end
  end

  should_have_the_same_structure_as EN, SW
end