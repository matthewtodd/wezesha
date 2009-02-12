# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  class LocalizedFormBuilder < ActionView::Helpers::FormBuilder
    def label(method, text = nil, options = {})
      super(method, text || localized(method), options)
    end

    private

    def localized(method_name)
      I18n.t(method_name, :scope => [:activerecord, :attributes, object.class.name.underscore], :raise => true)
    rescue I18n::MissingTranslationData => exception
      case I18n.locale
      when I18n.default_locale; nil
      else exception.message
      end
    end
  end
end
