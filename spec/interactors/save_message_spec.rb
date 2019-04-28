require 'rails_helper'

describe SaveMessage do
  let(:interactor) { described_class.call(params: params) }
  let(:params) do
    {
      whats_app: %w[90611122233],
      viber: %w[90611122255],
      telegram: %w[@username1],
      send_at: send_at,
      message: 'Привет'
    }.stringify_keys
  end

  context 'все данные валидны' do
    context 'время отправки передано' do
      let(:send_at) { '2019-04-28T14:21:58+03:00' }

      it 'сохранит все данные' do
        expect { interactor }.to change { UserMessage.count }.by(3)
        expect(interactor).to be_success
        expect(UserMessage.pluck(:send_at).size).to eq(3)
      end
    end

    context 'время отправки не передано' do
      let(:send_at) { nil }

      it 'сохранит время отправки добавит автоматически' do
        expect { interactor }.to change { UserMessage.count }.by(3)
        expect(interactor).to be_success
        expect(UserMessage.pluck(:send_at).size).to eq(3)
      end
    end
  end

  context 'часть данных не валидна' do
    let(:send_at) { '2019-04-28T14:21:58+03:00' }

    before do
      create(:user_message, provider: 'telegram', message: 'Привет', username: '@username1')
    end

    it 'вернёт сообщение об ошибке' do
      expect { interactor }.to change { UserMessage.count }.by(2)
      expect(interactor).to be_failure
      expect(interactor.errors).to eq('Ошибка сохранения для telegram#@username1: Uuid сообщение было отправлено ранее')
    end
  end
end
