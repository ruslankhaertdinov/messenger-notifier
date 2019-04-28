require 'rails_helper'

describe SaveMessage do
  let(:interactor) { described_class.call(params: params) }
  let(:params) do
    {
      whats_app: %w[90611122233 90611122244],
      viber: %w[90611122255 90611122266],
      telegram: %w[username1 username2],
      send_at: '2019-04-28T14:21:58+03:00',
      message: 'Привет'
    }.stringify_keys
  end

  context 'данные валидны' do
    it 'сохранит все данные' do
      expect { interactor }.to change { UserMessage.count }.by(6)
      expect(interactor).to be_success
    end
  end
end
