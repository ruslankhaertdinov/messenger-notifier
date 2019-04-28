require 'rails_helper'

describe MessengerApiStub do
  let(:service) { described_class.new }

  describe '#result' do
    it 'вернёт результат выполнения' do
      expect([true, false]).to include(service.result)
    end
  end
end
