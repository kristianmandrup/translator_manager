$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "translator_manager/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "translator_manager"
  s.version     = TranslatorManager::VERSION
  s.authors     = ["Kuldeep Aggarwal"]
  s.email       = ["kd.engineer@yahoo.co.in"]
  s.homepage    = 'https://github.com/kuldeepaggarwal/translator_manager'
  s.summary     = "Engine: Provides an api to get translations from translator"
  s.description = "Engine: Provides an api to get translations from translator."
  s.license     = "MIT"

  s.files       = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files  = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.1", "< 5"
  s.add_dependency 'translator_with_localeapp', '~> 1.0', '>= 1.0.2'

  s.add_development_dependency 'sqlite3', '~> 1.0', '>= 1.0.1'
end
