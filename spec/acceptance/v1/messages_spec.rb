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

    # parameter :email, "Email", required: true
    # parameter :password, "Password", required: true


    example_request "Send message with valid params" do
      # expect(response["user"]).to be_a_session_representation
      puts response_body
    end
  end
end
