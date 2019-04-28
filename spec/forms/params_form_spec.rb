require 'rails_helper'

describe ParamsForm do
  let(:form) { described_class.new(params) }

  context 'параметры валидны' do
    let(:params) do
      {
        usernames: %w[@david],
        message: 'Привет',
        providers: %w[whats_app viber telegramm],
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
        usernames: [],
        message: '',
        providers: %w[whats_app viber telegramm wrong_provider],
        send_at: 'wrong_date'
      }
    end

    it 'вернёт сообщение об ошибке' do
      expect(form).not_to be_valid
      expect(form.errors[:usernames]).to eq(["can't be blank"])
      expect(form.errors[:providers]).to eq(['Допустимы только значения из списка: ["whats_app", "viber", "telegramm"]'])
      expect(form.errors[:message]).to eq(["can't be blank"])
      expect(form.errors[:send_at]).to eq(["Время отправки должно быть в формате ISO8601"])
    end
  end
end
