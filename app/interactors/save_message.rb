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
        user_message = UserMessage.create(
                         username: username,
                         provider: provider,
                         message: params['message'],
                         send_at: send_at
                       )
        user_message.save || failed_params << "#{ provider }##{ username }: #{ user_message.errors.to_a.join(', ') }"
      end
    end
  end

  def send_at
    @send_at ||= params[:send_at].presence || Time.current.iso8601
  end
end
