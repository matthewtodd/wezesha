# TODO remove this AcceptsNestedAttributesForMatcher if Shoulda ever starts to provide it
module MatthewTodd
  module Shoulda
    module ActiveRecord

      module Matchers
        def accepts_nested_attributes_for(name)
          AcceptsNestedAttributesForMatcher.new(name)
        end

        class AcceptsNestedAttributesForMatcher
          def initialize(name)
            @name = name
          end

          def description
            "accept nested attributes for #{@name}"
          end

          def failure_message
            "Expected #{model_class.name} to accept nested attributes for #{@name}"
          end

          def matches?(subject)
            @subject = subject
            reflection_autosaves? && has_nested_attributes_setter?
          end

          private

          def reflection_autosaves?
            reflection.options[:autosave]
          end

          def reflection
            @reflection ||= model_class.reflect_on_association(@name)
          end

          def model_class
            @subject.class
          end

          def has_nested_attributes_setter?
            @subject.respond_to?(nested_attributes_setter)
          end

          def nested_attributes_setter
            "#{@name}_attributes="
          end
        end
      end

      module Macros
        include Matchers

        def should_accept_nested_attributes_for(*attributes)
          klass = model_class

          attributes.each do |attribute|
            matcher = accepts_nested_attributes_for(attribute)
            should matcher.description do
              assert_accepts(matcher, get_instance_of(klass))
            end
          end
        end
      end

    end
  end
end

ActiveSupport::TestCase.extend(MatthewTodd::Shoulda::ActiveRecord::Macros)
