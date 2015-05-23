TranslatorManager
--------------

This Engines extends the functionality of [Translator](https://github.com/kuldeepaggarwal/translator) gem which provides an API to get the translations for the given language/locale.


Installation
--------------

Add this line to your application's Gemfile:

```ruby
gem 'translator_with_localeapp', github: 'kuldeepaggarwal/translator_manager'
```

And then execute:

```shell
$ bundle install
```


Usage
-------

STEP1: copy the configuration file by executing the following command:

```shell
rails g translator_manager:install
```

This command will copy the configuation file in the _< app_folder >/config/initializers_
folder which will be like:

```ruby
# Use this hook to configure translator manager.
TranslatorManager.setup do |config|
  # ==> Param Key
  # This key will be used for finding the locale from the request
  # parameters. Defaults to `locale`.
  # config.param_key = :locale

  # Translator Configurations
  config.translator do |translator_config|
    # ==> Storage Configurations
    # translator_config.storage = :Redis
    # translator_config.storage_options = { host: 'localhost', port: 6379, db: 1 }

    # ==> Output Configuration
    # By default there is no logging, you can set it to any output
    # stream which respond to `puts`.
    # translator_config.output_stream = nil

    # ==> Localeapp Configuration
    translator_config.localeapp_api_key = ENV['LOCALEAPP_API_KEY']
    # It is the directory where localeapp will sync all the locales files.
    translator_config.data_directory = Rails.root.join('config', 'locales')
  end
end

```

See [here](https://github.com/kuldeepaggarwal/translator) for more configurations for translator block and settings.


STEP2: Add this line to your application's _routes.rb_:

```ruby
Rails.application.routes.draw do
  mount TranslatorManager::Engine, at: '/translations'
end
```

and it's done. Now you can access the translations at `http://localhost:3000/translations` end point.

STEP3: Restarte the rails server by using:

```shell
LOCALEAPP_API_KEY=<your localeapp key> rails server
```

This will synchronize your locale files(will also get file paths from I18n.config.config_path) and start the server.


Task
------

It also provides a rake task to sync locale files manually.

```shell
LOCALEAPP_API_KEY=<your localeapp key> rake translator_manager:synchronize
```


Testing
---------

Ensure Redis server is installed and started.

```shell
$ bundle install
$ bundle exec rspec spec
```
