module V1
  class MessagesController < ApplicationController
    def create
      byebug
      result = SendMessage.call(params: strong_params)
      byebug
      if result.success?
        render json: { result: 'success' }
      else
        render json: { result: 'error' }
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
