class ActiveRecord::Base
  def self.validates_equality_of(*attr_names)
    configuration = { :on => :save }
    configuration.update(attr_names.extract_options!)

    expected = configuration[:with]

    raise(ArgumentError, "An object with the expected value must be supplied as the :with option of the configuration hash") unless configuration.has_key?(:with)

    validates_each(attr_names, configuration) do |record, attr_name, value|
      expected_value = case expected
                       when Symbol
                         record.send(expected)
                       else
                         expected
                       end

      unless value == expected_value
        record.errors.add(attr_name, :equality, :default => configuration[:message], :value => value, :expected_value => expected_value)
      end
    end
  end
end
