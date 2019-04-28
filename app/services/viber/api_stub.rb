# заглушка интеграции с сервисом
module Viber
  class ApiStub
    def call
      [true, false].sample
    end
  end
end
