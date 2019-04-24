module WhatsApp
  class SendMessage
    include Interactor

    delegate :recipient, :message, :send_at, to: :context

    def call

    end
  end
end
