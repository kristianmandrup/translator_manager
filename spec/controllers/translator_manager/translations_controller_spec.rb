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
        get :index, locale: :pb
        expect(JSON.parse(response.body)).to eq({ 'name' => 'K' })
      end
    end
  end
end
