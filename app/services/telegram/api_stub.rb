# заглушка интеграции с сервисом
module Telegram
  class ApiStub
    def call
      [true, false].sample
    end
  end
end
