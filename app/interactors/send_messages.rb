class SendMessages
  include Interactor

  delegate :params, to: :context

  def call
    send_messages
  end

  private

  def send_messages
    recipients.each do |recipient|
      # SendMessageToUser.call(recipient: recipient, message: params[:message], send_at: params[:send_at])
      recipient.messengers.each do |messenger|
        messenger.send_message(recipient, message, send_at)
      end
    end
  end

  def recipients
    User.where(email: params[:recipients])
  end
end

# params
# {
#   message: 'Оплатить счёт за сентябрь',
#   recipients: ['user1@example.com', 'user2@example.com'],
#   send_at: '2019-04-24T21:33:07+03:00'
# }
