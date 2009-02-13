require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  should 'return host_without_subdomain' do
    self.stubs(:request).returns(ActionController::TestRequest.new)
    SubdomainFu.expects(:host_without_subdomain).with(request.host)
    host_without_subdomain
  end

  context 'other_locales' do
    context 'given the default locale' do
      setup { I18n.stubs(:locale).returns(I18n.default_locale) }

      should 'return the others' do
        expected_locales = { :sw => 'Kiswahili' }.with_indifferent_access
        assert_equal expected_locales, other_locales
      end
    end

    context 'given another locale' do
      setup { I18n.stubs(:locale).returns(:sw) }

      should 'return the others' do
        expected_locales = { :en => 'English' }.with_indifferent_access
        assert_equal expected_locales, other_locales
      end
    end
  end

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

      context 'generating a label with default and appended text' do
        setup { @form_builder.label(:foo, :append_text => 'APPENDED BAR') }

        before_should 'use translated method_name and appended text' do
          @template.expects(:label).with(:widget, :foo, 'TRANSLATED FOO APPENDED BAR', :object => @object)
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
            @template.expects(:label).with(:widget, :foo, 'Foo', :object => @object)
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

    context 'generating a label with specified and appended text' do
      setup { @form_builder.label(:foo, 'My Foo', :append_text => 'Bar') }

      before_should 'use specified and appended text' do
        @template.expects(:label).with(:widget, :foo, 'My Foo Bar', :object => @object)
      end
    end
  end
end
