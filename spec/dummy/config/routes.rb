Rails.application.routes.draw do
  mount TranslatorManager::Engine, at: '/translations'
end
