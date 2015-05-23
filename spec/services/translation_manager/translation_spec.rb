require 'rails_helper'

describe TranslatorManager::Translation do
  before do
    store.write('en', { name: 'kd' })
    store.write('pb', { name: 'K' })
  end
  after { store.clear }

  describe '.default_locale' do
    it 'is equal to `en`' do
      expect(TranslatorManager::Translation.default_locale).to eq('en')
    end
  end

  describe '.find_by_locale' do
    context 'when nil locale' do
      it 'returns data with default locale' do
        expect(TranslatorManager::Translation.find_by_locale(nil)).to eq({ name: 'kd' })
      end
    end

    context 'when locale' do
      it 'returns data corresponds with the locale' do
        expect(TranslatorManager::Translation.find_by_locale('pb')).to eq({ name: 'K' })
      end
    end
  end
end
