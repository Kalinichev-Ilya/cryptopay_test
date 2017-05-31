require_relative 'app/chatterbox'

chatterbox = Chatterbox.new
result = chatterbox.exchange_transfer('', :USD, :EUR)
error = JSON.parse(result.body)
puts error['amount']
