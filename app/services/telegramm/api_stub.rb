# заглушка интеграции с сервисом
module Telegramm
  class ApiStub
    def call
      [true, false].sample
    end
  end
end
