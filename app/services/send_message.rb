class SendMessage
  attr_reader :user_message
  private :user_message

  MAX_RETRY_COUNT = 10

  delegate :message, :username, to: :user_message

  def initialize(user_message)
    @user_message = user_message
  end

  def call
    response == true ? act_on_success : act_on_failure
  end

  private

  def response
    MessengerApiStub.new.result
  end

  def act_on_success
    message_to_logger('sent')
    user_message.update_column(:status, :sent)
  end

  def act_on_failure
    message_to_logger('not sent')

    if user_message.retry_count < MAX_RETRY_COUNT
      user_message.update_column(:retry_count, user_message.retry_count + 1)
    else
      user_message.update_column(:status, :cancelled)
    end
  end

  def message_to_logger(verb)
    string = "#{ self.class }##{ Time.new.iso8601 }: message <#{ message }> #{ verb } to <#{ username }>"
    puts string
    Rails.logger.warn(string)
  end
end
