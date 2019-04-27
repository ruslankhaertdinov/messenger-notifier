class SendMessageBase
  attr_reader :username, :message
  private :username, :message

  def initialize(username, message)
    @username = username
    @message = message
  end

  def call
    puts "#{ self.class }: message <#{ message }> sent to <#{ username }> at #{ Time.new.iso8601 }"
    true
  end
end
