require 'rails_helper'

describe SendMessage do
  let(:interactor) { described_class.call(params) }
  let!(:user) { create(:user) }
  let!(:provider1) { create(:provider, :whats_app) }
  let!(:provider2) { create(:provider, :viber) }
  let!(:provider3) { create(:provider, :telegramm) }
  let!(:providers_user1) { create(:providers_user, user: user, provider: provider1, username: '@username1') }
  let!(:providers_user2) { create(:providers_user, user: user, provider: provider2, username: '@username2') }
  let!(:providers_user3) { create(:providers_user, user: user, provider: provider3, username: '@username3') }
  let(:params) do
    {
      message: 'Hi!',
      users: [user.email],
      providers: ['whats_app', 'telegramm', 'viber']
    }
  end

  it 'отправит уведомления' do
    [WhatsApp::SendMessage, Viber::SendMessage, Telegramm::SendMessage].each do |klass|
      expect(klass).to receive_message_chain(:new, :call)
    end

    interactor
  end
end
