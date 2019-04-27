class ProvidersUser < ActiveRecord::Base
  belongs_to :provider
  belongs_to :user

  validates :user_id, uniqueness: { scope: :provider_id }
  validates :username, presence: true, uniqueness: { scope: :provider_id }
end
