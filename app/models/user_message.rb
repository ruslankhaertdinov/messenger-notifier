class UserMessage < ActiveRecord::Base
  before_validation :set_uuid

  enum provider: { whats_app: 'whats_app', viber: 'viber', telegramm: 'telegramm' }
  enum status: { queued: 'queued', sent: 'sent', cancelled: 'cancelled' }

  validates :username, :message, :uuid, :provider, :status, presence: true
  validates :uuid, uniqueness: true

  private

  def set_uuid
    string = [username, provider, message].join
    self.uuid = Digest::SHA256.hexdigest(string)
  end
end
