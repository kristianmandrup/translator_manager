require 'rails_helper'

describe TranslatorManager do
  describe '.sync!' do
    context 'when have internet connection' do
      before { allow(TranslatorManager::SystemHelper).to receive(:internet_connection?).and_return(true) }

      it 'syncs translation' do
        expect(Translator).to receive(:load!).with(I18n.config.load_path)
        TranslatorManager.sync!
      end
    end

    context 'when does not have internet connection' do
      before { allow(TranslatorManager::SystemHelper).to receive(:internet_connection?).and_return(false) }

      it 'does not sync translations' do
        expect(Translator).to_not receive(:load!)
        TranslatorManager.sync!
      end
    end
  end

  describe '.setup' do
    it 'set ups the values for TranslatorManager' do
      original_key = TranslatorManager.param_key
      begin
        TranslatorManager.setup do |config|
          config.param_key = :kd
          config.translator do |translator_config|

          end
        end
        expect(TranslatorManager.param_key).to eq(:kd)
      ensure
        TranslatorManager.param_key = original_key
      end
    end
  end
end
