require 'rails_helper'

describe UserMessage do
  let(:attributes) { { username: '90611122233', message: 'Привет', provider: 'whats_app' } }
  let!(:user_message1) { create(:user_message, attributes) }
  let!(:user_message2) { create(:user_message, username: '90611122233', message: 'Привет', provider: 'viber') }

  describe 'валидация' do
    it 'проверит уникальность uuid' do
      expect(user_message1).to be_valid
      expect(user_message2).to be_valid
      expect(user_message1.uuid).to be_present
      expect(user_message2.uuid).to be_present

      user_message3 = build(:user_message, attributes)
      expect(user_message3).not_to be_valid
      expect(user_message3.errors[:uuid]).to contain_exactly('сообщение было отправлено ранее')
    end
  end
end
