# TODO remove this if Shoulda ever starts to provide it
module MatthewTodd
  module Shoulda
    module ActiveRecord

      module Macros
        def should_ensure_length_at_most(attribute, max_length, opts = {})
          short_message = get_options!([opts], :short_message)
          klass = model_class

          matcher = ensure_length_of(attribute).
            is_at_most(max_length).
            with_short_message(short_message)

          should matcher.description do
            assert_accepts matcher, get_instance_of(klass)
          end
        end
      end

    end
  end
end

ActiveSupport::TestCase.extend(MatthewTodd::Shoulda::ActiveRecord::Macros)
