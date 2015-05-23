require_dependency "translator_manager/application_controller"

module TranslatorManager
  class TranslationsController < ApplicationController
    def index
      render json: Translation.find_by_locale(params[TranslatorManager.param_key])
    end
  end
end
