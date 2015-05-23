require 'rails/generators/base'

module TranslatorManager
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../../templates', __FILE__)

      desc 'Creates a Translator initializer'

      def copy_initializer
        template 'translator.rb', 'config/initializers/translator.rb'
      end
    end
  end
end
