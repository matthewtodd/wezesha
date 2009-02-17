module MatthewTodd
  module Shoulda
    module ActiveRecord

      module Macros
        def any_attribute_other_than(*attributes)
          get_instance_of(model_class).attribute_names - attributes.map(&:to_s)
        end
      end

    end
  end
end

ActiveSupport::TestCase.extend(MatthewTodd::Shoulda::ActiveRecord::Macros)
