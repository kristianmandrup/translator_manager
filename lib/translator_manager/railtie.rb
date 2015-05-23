module TranslatorManager
  class Railtie < Rails::Railtie
    initializer :synchronizing_translations, after: :app do |app|
      app.config.after_initialize do
        TranslatorManager.sync! if defined?(Rails::Server)
        TranslatorManager.setup!
      end
    end
  end
end
