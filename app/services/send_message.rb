class SendMessage
  attr_reader :user_message
  private :user_message

  MAX_RETRY_COUNT = 10

  delegate :message, :username, :provider, to: :user_message

  def initialize(user_message)
    @user_message = user_message
  end

  def call
    return unless user_message.queued?

    response == true ? act_on_success : act_on_failure
  end

  private

  def response
    klass = "#{ provider }/api_stub".classify.constantize
    klass.new.call
  end

  def act_on_success
    message_to_logger('sent')
    user_message.update_column(:status, :sent)
  end

  def act_on_failure
    message_to_logger('not sent')

    if user_message.retry_count < MAX_RETRY_COUNT
      user_message.increment!(:retry_count)
    else
      user_message.cancelled!
    end
  end

  def message_to_logger(verb)
    current_time = Time.new.utc.strftime('%d-%m-%Y %H:%M:%S')
    string = "#{ self.class } (#{ current_time }): message '#{ message }' #{ verb } to '#{ provider }/#{ username }'"
    puts string
    Rails.logger.warn(string)
  end
end
