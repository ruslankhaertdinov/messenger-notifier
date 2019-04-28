class SaveMessage
  include Interactor

  delegate :params, :failed_params, to: :context

  before do
    context.failed_params = []
  end

  def call
    save_message
    context.fail!(errors: "Ошибка сохранения для #{ failed_params.join(', ') }") if failed_params.any?
  end

  private

  def save_message
    ParamsForm::PROVIDERS.each do |provider|
      params[provider.to_s].to_a.each do |username|
        message_params = { username: username, provider: provider, message: params['message'], send_at: send_at }
        user_message = UserMessage.new(message_params)
        user_message.save || failed_params << "#{ provider }##{ username }: #{ user_message.errors.to_a.join(', ') }"
      end
    end
  end

  def send_at
    given_time = params[:send_at]
    utc_time = given_time.present? ? DateTime.parse(given_time).utc.iso8601 : Time.new.utc.iso8601
    @send_at ||= utc_time
  end
end
