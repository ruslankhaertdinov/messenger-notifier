require 'sidekiq-scheduler'

module Schedule
  class SendMessagesWorker
    include Sidekiq::Worker
    sidekiq_options retry: false

    def perform
      UserMessage.queued.actual.each do |user_message|
        SendMessage.new(user_message).call
      end
    end
  end
end
