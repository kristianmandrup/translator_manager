require 'rails_helper'

describe TranslatorManager::TranslationsController do
  before do
    @routes = TranslatorManager::Engine.routes
    store.write('en', { name: 'kd' })
    store.write('pb', { name: 'K' })
  end
  after { store.clear }

  describe '#index' do
    context 'when no params' do
      it 'returns data with default locale' do
        get :index
        expect(JSON.parse(response.body)).to eq({ 'name' => 'kd' })
      end
    end

    context 'when params' do
      it 'returns data with passed locale' do
        get :index, TranslatorManager.param_key => :pb
        expect(JSON.parse(response.body)).to eq({ 'name' => 'K' })
      end
    end

    context 'when TranslatorManager.param_key is `location`' do
      before do
        @original_key = TranslatorManager.param_key
        TranslatorManager.param_key = :location
      end

      after { TranslatorManager.param_key = @original_key }

      it 'returns data with default locale is param name is different' do
        get :index, locale: :pb
        expect(JSON.parse(response.body)).to eq({ 'name' => 'kd' })
        get :index, TranslatorManager.param_key => :pb
        expect(JSON.parse(response.body)).to eq({ 'name' => 'K' })
      end
    end
  end
end
