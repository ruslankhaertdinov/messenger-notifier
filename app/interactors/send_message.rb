class SendMessage
  include Interactor

  delegate :message, :send_at, to: :context

  def call
    send_messages
  end

  private

  def send_messages
    users.each do |user|
      user.providers.where(id: providers.ids).each do |provider|
        send_message(provider.kind, user.username_for(provider), message)
      end
    end
  end

  def users
    @users ||= User.where(email: context[:users])
  end

  def providers
    @providers ||= Provider.where(slug: context[:providers])
  end

  def send_message(kind, username, message)
    klass = "#{ kind }/send_message".classify.constantize
    klass.new(username, message).call
  end
end
