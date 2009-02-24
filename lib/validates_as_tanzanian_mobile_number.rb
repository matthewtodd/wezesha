class ActiveRecord::Base
  def self.validates_as_tanzanian_mobile_number(*attr_names)
    configuration = { :on => :save }
    configuration.update(attr_names.extract_options!)
    configuration.update(:with => /^2557\d{8}$/)

    validates_format_of(*(attr_names << configuration))
  end
end
