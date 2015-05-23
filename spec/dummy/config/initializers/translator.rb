# Use this hook to configure translator manager.
Translator.setup do |config|
  # ==> Storage Configurations
  # config.storage = :Redis
  # config.storage_options = { host: 'localhost', port: 6379, db: 1 }

  # ==> Output Configuration
  # By default there is no logging, you can set it to any output
  # stream which respond to `puts`.
  # config.output_stream = nil

  # ==> Localeapp Configuration
  config.localeapp_api_key = ENV['LOCALEAPP_API_KEY']
  # It is the directory where localeapp will sync all the locales files.
  config.data_directory = Rails.root.join('config', 'locales')
end
