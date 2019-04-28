module V1
  class MessagesController < ApplicationController
    def create
      result = HandleRequest.call(params: strong_params)
      if result.success?
        render json: { success: 'true' }
      else
        render json: { success: 'false', errors: [result.errors] }
      end
    end

    private

    def strong_params
      # {
      #   message: 'Оплатить по счёту',
      #   whats_app: ['9061111111'],
      #   viber: ['9062222222'],
      #   telegram: ['@username'],
      #   send_at: '2019-04-24T21:33:07+03:00'
      # }
      params.permit(:message, :send_at, **providers)
    end

    # { whats_app: [], viber: [], telegram: [] }
    def providers
      {}.tap do |opts|
        ParamsForm::PROVIDERS.each { |provider| opts[provider] = [] }
      end
    end
  end
end
