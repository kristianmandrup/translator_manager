namespace :translator_manager do
  desc 'Synchronize translations with localeapp'
  task :synchronize => :environment do
    TranslatorManager.sync!
  end
end
