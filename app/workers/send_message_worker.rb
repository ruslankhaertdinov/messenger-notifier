class SendMessageWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform
    UserMessage.queued.each do |user_message|
      SendMessage.new(user_message).call
    end
  end

  private

  def user_messages
    UserMessage.queued
  end
end
