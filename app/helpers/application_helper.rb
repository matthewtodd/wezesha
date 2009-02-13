# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  class LocalizedFormBuilder < ActionView::Helpers::FormBuilder
    def label(*args)
      options = args.extract_options!
      method  = args.shift
      text    = args.shift

      super(method, label_text(method, text, options.delete(:append_text)), options)
    end

    private

    def label_text(method_name, text, append_text)
      [text || localized(method_name), append_text].compact.join(' ')
    end

    def localized(method_name)
      I18n.t(method_name, :scope => [:activerecord, :attributes, object.class.name.underscore], :raise => true)
    rescue I18n::MissingTranslationData => exception
      case I18n.locale
      when I18n.default_locale; method_name.to_s.humanize
      else exception.message
      end
    end
  end
end
