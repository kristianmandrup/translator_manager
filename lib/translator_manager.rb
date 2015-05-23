require 'translator'

module TranslatorManager
  autoload :SystemHelper, 'translator_manager/helpers/system_helper'

  mattr_accessor :param_key
  @@param_key = :locale

  mattr_accessor :fallback_required
  @@fallback_required = true

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

    def setup!
      I18n.backend = new_store
      I18n.load_path += Dir["#{ Translator.data_directory }/*.{rb,yml}"]
    end

    private
      def new_store
        new_store = I18n::Backend::KeyValue.new(Translator::Store.instance)
        fallback_required ? I18n::Backend::Chain.new(new_store, I18n.backend) : new_store
      end
  end

  extend ClassMethods
end

require 'translator_manager/engine'
require 'translator_manager/railtie'
