class Provider < ActiveRecord::Base
  enum kind: %i[whats_app viber telegramm]

  validates :kind, uniqueness: true
end
