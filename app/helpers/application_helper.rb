# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def entry_source_detail(source)
    case source
    when NilClass
      ''
    when Message
      link_to source.recipient, source
    else
      raise
    end
  end

  # Step 3, The size: You can specify a "size" or "s" parameter to the URL
  # between 1 and 512 (pixels.) If you ommit this step we use a default size
  # of 80 pixels.
  #
  # Step 4, The rating: You can specify a "rating" or "r" parameter to the URL
  # of g, pg, r, or x. If you ommit this step we use a default rating of g.
  #
  # Step 5, The default: You can specify a "default" or "d" parameter to the
  # URL, this should be urlencoded so as to make it to our servers intact.
  # There are "special" values that you may pass to this parameter which
  # produce dynamic default images. These are "identicon" "monsterid" and
  # "wavatar". If omitted we will serve up our default image, the blue G.
  def gravatar(email, size=32)
    image_tag "http://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(email.downcase)}?size=#{size}", :width => size, :height => size
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
