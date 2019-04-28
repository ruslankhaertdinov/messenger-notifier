# заглушка интеграции с сервисом
module WhatsApp
  class ApiStub
    def call
      [true, false].sample
    end
  end
end
