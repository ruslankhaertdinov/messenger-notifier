require 'rails_helper'

describe ValidateParams do
  let(:interactor) { described_class.call(params: params) }

  context 'параметры валидные' do
    let(:params) do
      {
        telegram: %w[@david],
        message: 'Привет'
      }
    end

    it 'вернёт успешный ответ' do
      expect(interactor).to be_success
    end
  end

  context 'параметры невалидные' do
    let(:params) { {} }

    it 'вернёт сообщение об ошибке' do
      expect(interactor).to be_failure
      expect(interactor.errors).to be_present
    end
  end
end
