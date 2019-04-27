class Message < ActiveRecord::Base
  belongs_to :users_provider

  validates :body, uniqueness: { scope: :users_provider_id }
end
