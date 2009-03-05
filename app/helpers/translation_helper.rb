# FIXME remove this override of TranslationHelper.translate when Rails 2.3.1 is released.
module TranslationHelper
  def translate(key, options = {})
    options[:raise] = true
    I18n.translate(scope_key_by_partial(key), options)
  rescue I18n::MissingTranslationData => e
    keys = I18n.send(:normalize_translation_keys, e.locale, e.key, e.options[:scope])
    content_tag('span', keys.join(', '), :class => 'translation_missing')
  end
  alias :t :translate

  # Delegates to I18n.localize with no additional functionality.
  def localize(*args)
    I18n.localize *args
  end
  alias :l :localize

  private

  def scope_key_by_partial(key)
    if key.to_s.first == "."
      template.path_without_format_and_extension.gsub(%r{/_?}, ".") + key.to_s
    else
      key
    end
  end
end
