class SaveMessage
  include Interactor

  delegate :params, to: :context

  def call
    save_message || context.fail!(errors: 'Ошибка сохранения, повторите запрос позже')
  end

  private

  def save_message
    ParamsForm::PROVIDERS.each do |provider|
      params[provider.to_s].to_a.each do |username|
        UserMessage.create(
          username: username,
          provider: provider,
          message: params['message'],
          send_at: send_at
        )
      end
    end
  end

  def send_at
    @send_at ||= params[:send_at].presence || Time.current.iso8601
  end
end
