class ParamsForm
  include ActiveModel::Validations

  PROVIDERS = %w[whats_app viber telegramm].freeze

  attr_reader :usernames, :providers, :message, :send_at
  private :usernames, :providers, :message, :send_at

  def initialize(params)
    @usernames = params[:usernames].to_a
    @providers = params[:providers].to_a
    @message = params[:message]
    @send_at = params[:send_at]
  end

  validates :usernames, :providers, :message, presence: true
  validate :providers_list
  validate :send_at_format

  private

  def providers_list
    return if providers.all? { |provider| provider.in?(PROVIDERS) }

    errors.add(:providers, "Допустимы только значения из списка: #{ PROVIDERS }")
  end

  def send_at_format
    return if send_at.blank?

    DateTime.parse(send_at)
  rescue ArgumentError
    errors.add(:send_at, "Время отправки должно быть в формате ISO8601")
  end
end
