require 'test_helper'

class SwahiliLocaleTest < ActiveSupport::TestCase
  EN = YAML.load_file(Rails.root.join('config', 'locales', 'en.yml')).fetch('en')
  SW = YAML.load_file(Rails.root.join('config', 'locales', 'sw.yml')).fetch('sw')

  def self.attributes_that_should_be_translated_for(klass)
    if klass.accessible_attributes
      klass.accessible_attributes
    else
      klass.new.attribute_names - klass.new.send(:attributes_protected_by_default) - (klass.protected_attributes || [])
    end    
  end

  def self.model_classes
    ActiveRecord::Base.subclasses
  end

  def self.translation_paths_for(hash)
    hash.map do |key, value|
      if value.is_a? Hash
        translation_paths_for(value).map { |path| "#{key}.#{path}"}
      else
        [key]
      end
    end.flatten
  end
  
  def self.should_have_a_translation_for(path, actual, reason = nil)
    should "have a translation for #{path} #{reason}" do
      path_components = path.split('.')
      final_key = path_components.pop
      
      while path_key = path_components.shift
        assert_instance_of Hash, actual[path_key], "translation key missing: #{path} (at #{path_key})"
        actual = actual[path_key]
      end
      
      assert_instance_of String, actual[final_key], "translation key missing: #{path}"
      assert !actual[final_key].blank?, "translation value blank: #{path}"
    end
  end
  
  def self.should_have_the_same_structure_as(expected, actual)
    translation_paths_for(expected).each do |path|
      should_have_a_translation_for(path, actual, 'to match expected structure')
    end
  end

  def self.should_translate_model_name_and_attributes(klass, actual)
    return unless klass.table_exists?
    should_have_a_translation_for("activerecord.models.#{klass.name.underscore}", actual)
    attributes_that_should_be_translated_for(klass).each do |attribute_name|
      should_have_a_translation_for("activerecord.attributes.#{klass.name.underscore}.#{attribute_name}", actual)      
    end
  end
  
  should_have_the_same_structure_as EN, SW
  model_classes.each { |klass| should_translate_model_name_and_attributes klass, SW }
end