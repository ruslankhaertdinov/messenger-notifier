# заглушка сервиса отправки сообщений провайдеру
class MessengerApiStub
  def result
    [true, false].sample
  end
end
