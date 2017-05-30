require_relative 'app/chatterbox'

chatterbox = Chatterbox.new
result = chatterbox.exchange_transfer('', :USD, :EUR)
puts result.body
