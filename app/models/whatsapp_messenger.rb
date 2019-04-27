# class Messenger < ActiveRecord::Base
#   has_many :users

#   enum kinds: { whatsapp: 'whatsapp', viber: 'viber', telegramm: 'telegramm' }

#   def send_message(recipient, message, send_at)
#     klass = "#{ kind }/send_message".classify.constantize
#     klass.new(recipient, message, send_at).send_message
#   end
# end
