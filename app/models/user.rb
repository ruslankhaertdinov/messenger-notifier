class User < ActiveRecord::Base
  acts_as_token_authenticatable

  devise :database_authenticatable, :registerable,
    :recoverable, :trackable, :validatable

  has_many :providers_users, dependent: :destroy
  has_many :providers, through: :providers_users

  def username_for(provider)
    # stub
    '@adam_smith'
  end
end
