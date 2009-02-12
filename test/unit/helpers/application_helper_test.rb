require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  context 'LocalizedFormBuilder' do
    setup do
      @form_builder = LocalizedFormBuilder.new(:widget, @object = stub, @template = stub, {}, nil)
    end

    context 'when a translation is present' do
      setup do
        I18n.stubs(:t).with(:foo, :scope => [:activerecord, :attributes, 'mocha/mock'], :raise => true).returns('TRANSLATED FOO')
      end

      context 'generating a label with default text' do
        setup { @form_builder.label(:foo) }

        before_should 'use translated method_name' do
          @template.expects(:label).with(:widget, :foo, 'TRANSLATED FOO', :object => @object)
        end
      end
    end

    context 'when a translation is absent' do
      setup { I18n.stubs(:t).with(:foo, :scope => [:activerecord, :attributes, 'mocha/mock'], :raise => true).raises(@exception = I18n::MissingTranslationData.new(:LOCALE, :KEY, {})) }

      context 'and we are in the default locale' do
        setup { I18n.stubs(:locale).returns(I18n.default_locale) }

        context 'generating a label with default text' do
          setup { @form_builder.label(:foo) }

          before_should 'use default template behavior' do
            @template.expects(:label).with(:widget, :foo, nil, :object => @object)
          end
        end
      end

      context 'and we are in a non-default locale' do
        setup { I18n.stubs(:locale).returns(:NON_DEFAULT) }

        context 'generating a label with default text' do
          setup { @form_builder.label(:foo) }

          before_should 'use missing translation message' do
            @template.expects(:label).with(:widget, :foo, @exception.message, :object => @object)
          end
        end
      end
    end

    context 'generating a label with specified text' do
      setup { @form_builder.label(:foo, 'My Foo') }

      before_should 'use specified text' do
        @template.expects(:label).with(:widget, :foo, 'My Foo', :object => @object)
      end
    end
  end
end
