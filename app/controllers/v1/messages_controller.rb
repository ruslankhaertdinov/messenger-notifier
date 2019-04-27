module V1
  class MessagesController < ApplicationController
    def create
      result = SendMessage.call(params: strong_params)
      if result.success?
        render json: { success: 'true' }
      else
        render json: { success: 'false', errors: [result.errors] }
      end
    end

    private

    def strong_params
      # {
      #   users: ['user1@example.com', 'user2@example.com'],
      #   message: 'Оплатить по счёту',
      #   providers: ['whatsapp', 'viber'],
      #   send_at: '2019-04-24T21:33:07+03:00'
      # }
      params.permit(:message, :send_at, users: [], providers: [])
    end
  end
end
