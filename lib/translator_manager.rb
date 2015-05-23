require 'translator'

module TranslatorManager
  autoload :SystemHelper, 'translator_manager/helpers/system_helper'

  def self.sync!(paths = nil)
    paths = Array(paths)
    paths += I18n.config.load_path if defined?(I18n)

    if SystemHelper.internet_connection?
      puts 'Synchronizing translations...'
      ::Translator.load!(paths)
    else
      puts 'No Internet connection, failed to synchronize translations'
    end
  end
end

require 'translator_manager/engine'
require 'translator_manager/railtie'
