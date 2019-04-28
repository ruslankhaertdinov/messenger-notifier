class ParamsForm
  include ActiveModel::Validations

  PROVIDERS = %i[whats_app viber telegram].freeze

  attr_reader :message, :send_at
  attr_reader(*PROVIDERS)
  private :message, :send_at
  private(*PROVIDERS)

  def initialize(params)
    @message = params[:message]
    @send_at = params[:send_at]

    PROVIDERS.each do |provider|
      instance_variable_set("@#{ provider }", params[provider].to_a)
    end
  end

  validates :message, presence: true
  validate :usernames_list
  validate :send_at_format

  private

  def usernames_list
    return if PROVIDERS.any? { |provider| send(provider).any? }

    errors.add(:usernames, 'Список получателей не может быть пустым')
  end

  def send_at_format
    return if send_at.blank?

    DateTime.parse(send_at)
  rescue ArgumentError
    errors.add(:send_at, "Время отправки должно быть в формате ISO8601")
  end
end
