module V1
  class SessionsController < ApplicationController
    # def create
      # user = AuthenticateUser.call(warden: warden).user
      # respond_with(user, serializer: SessionSerializer)
    # end

    def create
      result = SendMessages.call(params: strong_params)
    end

    private

    def strong_params
      # заглушка
      params
    end
  end
end
