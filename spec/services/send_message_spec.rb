require 'rails_helper'

describe SendMessage do
  let(:service) { described_class.new(user_message) }
  let!(:user_message) { create(:user_message, username: '@username', provider: 'whats_app', message: 'Привет') }

  before do
    allow(MessengerApiStub).to receive_message_chain(:new, :result).and_return(result)
  end

  describe '#call' do
    context 'успешный результат' do
      let(:result) { true }

      it 'обновит статус сообщения' do
        expect { service.call }.to change { user_message.reload.status }.from('queued').to('sent')
      end
    end
  end
end
