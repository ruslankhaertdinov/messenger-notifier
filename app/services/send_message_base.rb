class SendMessageBase
  attr_reader :username, :message
  private :username, :message

  def initialize(username, message)
    @username = username
    @message = message
  end

  def call
    if response == true
      puts "#{ self.class }##{ Time.new.iso8601 }: message <#{ message }> sent to <#{ username }>"
      true
    else
      puts "#{ self.class }##{ Time.new.iso8601 }: message <#{ message }> not sent to <#{ username }>"
      false
    end
  end

  private

  # заглушка
  def response
    [true, false].sample
  end
end
