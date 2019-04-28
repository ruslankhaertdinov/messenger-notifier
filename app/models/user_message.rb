class UserMessage < ActiveRecord::Base
  before_validation :set_uuid, :set_send_at

  enum provider: { whats_app: 'whats_app', viber: 'viber', telegram: 'telegram' }
  enum status: { queued: 'queued', sent: 'sent', cancelled: 'cancelled' }

  validates :username, :message, :uuid, :provider, :status, :send_at, presence: true
  validates :uuid, uniqueness: { message: 'сообщение было отправлено ранее' }

  scope :actual, -> { where('user_messages.send_at <= ?', Time.new.utc.iso8601) }

  private

  def set_uuid
    string = [username, provider, message].join
    self.uuid = Digest::SHA256.hexdigest(string)
  end

  def set_send_at
    self.send_at ||= Time.new.utc.iso8601
  end
end
