require 'rails_helper'

describe ParamsForm do
  let(:form) { described_class.new(params) }

  context 'параметры валидны' do
    let(:params) do
      {
        message: 'Привет',
        whats_app: %w[90611122233],
        viber: %w[90611122255],
        telegram: %w[@username1],
        send_at: '2019-04-28T13:55:33+03:00'
      }
    end

    it 'вернёт успешный ответ' do
      expect(form).to be_valid
    end
  end

  context 'параметры невалидны' do
    let(:params) do
      {
        message: '',
        whats_app: [],
        viber: [],
        telegram: [],
        send_at: 'wrong_date'
      }
    end

    it 'вернёт сообщение об ошибке' do
      expect(form).not_to be_valid
      expect(form.errors[:usernames]).to eq(['Список получателей не может быть пустым'])
      expect(form.errors[:message]).to eq(["can't be blank"])
      expect(form.errors[:send_at]).to eq(["Время отправки должно быть в формате ISO8601"])
    end
  end
end
