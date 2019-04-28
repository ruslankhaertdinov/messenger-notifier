class SendMessage
  attr_reader :user_message
  private :user_message

  def initialize(user_message)
    @user_message = user_message
  end

  def call
    response == true ? act_on_success : act_on_failure
  end

  private

  # заглушка
  def response
    [true, false].sample
  end

  def act_on_success
    puts "#{ self.class }##{ Time.new.iso8601 }: message <#{ message }> sent to <#{ username }>"
    user_message.update_column(:status, :sent)
  end

  def act_on_failure
    puts "#{ self.class }##{ Time.new.iso8601 }: message <#{ message }> not sent to <#{ username }>"
  end
end
