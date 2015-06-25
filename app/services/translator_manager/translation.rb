module TranslatorManager
  class Translation
    def self.find_by_locale(locale)
      ::Translator::Store.instance[locale.to_s.presence || default_locale]
    end

    def self.default_locale
      'en'
    end
  end
end
