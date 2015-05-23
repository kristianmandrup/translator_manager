require 'translator'

module TranslatorManager
  autoload :SystemHelper, 'translator_manager/helpers/system_helper'

  mattr_accessor :param_key
  @@param_key = :locale

  module ClassMethods
    def setup
      yield self
    end

    def translator(&block)
      Translator.setup do |translator_config|
        translator_config.instance_eval(&block)
      end
    end

    def sync!(paths = nil)
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

  extend ClassMethods
end

require 'translator_manager/engine'
require 'translator_manager/railtie'
