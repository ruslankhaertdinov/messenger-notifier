require "rails_helper"
require "rspec_api_documentation/dsl"

resource "Messages" do
  header "Accept", "application/json"

  # subject(:response) { json_response_body }

  post "/v1/messages" do
    let!(:user1) { create :user, email: 'user1@example.com' }
    let!(:user2) { create :user, email: 'user2@example.com' }
    let!(:provider1) { create(:provider, :whats_app) }
    let!(:provider2) { create(:provider, :viber) }
    let!(:provider3) { create(:provider, :telegramm) }
    let!(:providers_user1) { create(:providers_user, user: user1, provider: provider1, username: 'username1') }
    let!(:providers_user2) { create(:providers_user, user: user1, provider: provider2, username: 'username2') }
    let!(:providers_user3) { create(:providers_user, user: user1, provider: provider3, username: 'username3') }
    let!(:providers_user4) { create(:providers_user, user: user2, provider: provider1, username: 'username4') }

    let(:params) do
      {
        users: [user1.email],
        message: 'Hi!',
        providers: [provider1.slug, provider3.slug]
      }
    end

    parameter :message, 'Сообщение', type: :string, required: true
    parameter :send_at, 'Желаемое время отправки (отправляется немедленно, если не передано)',
                        type: :string,
                        comment: 'В формате iso8601, например: 2019-04-27T14:08:25+03:00'
    parameter :providers, 'Список мессенджеров',
                          type: :array,
                          comment: 'Пример: [whats_app, viber, telegramm]',
                          required: true
    parameter :users, 'Список эл. адресов пользователей',
                      type: :array,
                      comment: 'Пример: [user1@example.com, user2@example.com]',
                      required: true

    example_request "Успешная отправка" do
      expect(response_body['success']).to eq('success')
    end

    # example_request "Невалидные параметры" do
    #   expect(response_body['success']).to eq('error')
    # end
  end
end
