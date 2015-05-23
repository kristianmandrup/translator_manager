# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'simplecov'

SimpleCov.start do
  add_filter 'config/initializers/'
  add_filter 'spec/support'
  add_filter 'spec/shared'
  add_filter 'spec/factories'
end

ENV['RAILS_ENV'] ||= 'test'
require 'spec_helper'
require File.expand_path('../../spec/dummy/config/environment.rb',  __FILE__)

require 'rspec/rails'
Translator.setup do |config|
  config.synchronization_data_file = File.expand_path('../.localeapp/log.yml', __FILE__)
  config.data_directory            = File.expand_path('../locales', __FILE__)
end

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
Dir[File.expand_path('../support/**/*.rb', __FILE__)].each { |f| require f }

RSpec.configure do |config|
  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, :type => :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  config.after(:all) do
    FileUtils.rm_rf(Translator.data_directory)
    FileUtils.rm_rf(Pathname.new(Translator.synchronization_data_file).parent)
  end
end

if defined?(RUBY_ENGINE) && RUBY_ENGINE == 'ruby'
  module Kernel
    alias :__at_exit :at_exit
    def at_exit(&block)
      __at_exit do
        exit_status = $!.status if $!.is_a?(SystemExit)
        block.call
        exit exit_status if exit_status
      end
    end
  end
end
