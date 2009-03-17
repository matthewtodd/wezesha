# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def entry_source_detail(source)
    case source
    when Message
      link_to source.recipient, source
    when NilClass
      ''
    when Payment::Notification
      ''
    else
      raise "entry_source_detail doesn't know how to handle #{source.class}"
    end
  end

  def host_without_subdomain
    SubdomainFu.host_without_subdomain(request.host)
  end

  def money(amount)
    if amount.negative?
      content_tag(:span, "(#{amount.negated})", :class => 'money negative')
    else
      content_tag(:span, amount, :class => 'money positive')
    end
  end

  def other_locales
    other_locales = {}.with_indifferent_access
    I18n.available_locales.each { |locale| other_locales[locale] = t(:locale_name, :locale => locale) }
    other_locales.except(I18n.locale)
  end

  class LocalizedFormBuilder < ActionView::Helpers::FormBuilder
    def error_message_on(method, *args)
      super.tap { |error| error.concat('.') unless error.blank? }
    end

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
