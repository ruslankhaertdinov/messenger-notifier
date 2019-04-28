module Schedules
  class SendMessagesWorker
    include Sidekiq::Worker
    sidekiq_options retry: false

    def perform
      UserMessage.queued.each do |user_message|
        SendMessage.new(user_message).call
      end
    end
  end
end
