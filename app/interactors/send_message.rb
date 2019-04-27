class SendMessage
  include Interactor

  delegate :params, to: :context

  def call
    byebug
    send_message
  end

  private

  def send_message
    users.each do |user|
      byebug
      user.providers.where(id: providers.ids).each do |provider|
        byebug
        send_message(provider.kind, user.username_for(provider), params[:message])
      end
    end
  end

  def users
    User.where(email: params[:users])
  end

  def providers
    Provider.where(slug: params[:providers])
  end

  def send_message(kind, username, message)
    byebug
    klass = "#{ kind }/send_message".classify.constantize
    byebug
    klass.new(username, message).send_message
  end
end
