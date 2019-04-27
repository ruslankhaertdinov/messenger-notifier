require 'rails_helper'

describe SendMessage do
  let(:interactor) { described_class.call(params) }
  let(:user) { create(:user) }
  let(:params) do
    {
      message: 'Hi!',
      users: [user.email],
      providers: ['whats_app', 'telegramm', 'viber']
    }
  end

  before do
    allow(WhatsApp::SendMessage).to receive_message_chain(:new, :call)
    allow(Viber::SendMessage).to receive_message_chain(:new, :call)
    allow(Telegramm::SendMessage).to receive_message_chain(:new, :call)

  end

  it 'отправит уведомления' do
  end
end
