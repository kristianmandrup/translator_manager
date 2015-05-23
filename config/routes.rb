TranslatorManager::Engine.routes.draw do
  resources :translations, only: :index

  root 'translations#index'
end
