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
        expect(user_message.retry_count).to eq(0)
      end
    end

    context 'ошибочный результат' do
      let(:result) { false }

      before do
        user_message.update_column(:retry_count, (SendMessage::MAX_RETRY_COUNT - 1))
      end

      it 'увеличит счётчик повторов' do
        expect(user_message.retry_count).to eq(SendMessage::MAX_RETRY_COUNT - 1)

        service.call
        user_message.reload

        expect(user_message).to be_queued
        expect(user_message.retry_count).to eq(SendMessage::MAX_RETRY_COUNT)

        service.call
        user_message.reload

        expect(user_message).to be_cancelled
      end
    end
  end
end
