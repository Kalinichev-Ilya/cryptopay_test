require 'uri'
require 'httpi'
require_relative 'config'

# Helps to form a request to the server,
# and accept the response in a convenient form for tests
#
# 'amount': сумма перевода,
# 'amount_currency': валюта поля Amount в формате BTC\EUR\USD\GBP,
# 'from_account': UUID аккаунта пользователя, с которого делается перевод,
# 'to_account': UUID аккаунта пользователя, на который делается перевод.
class Chatterbox

  # amount: the number of transferred funds
  # from: currency from_account which the transaction is made 'Ex. :BTC'
  # to: currency to_account to which the transaction is made 'Ex :EUR'
  #
  # Returns http request obj
  def exchange_transfer(amount, from, to)
    api_key = Config.auth_key
    url = URI(Config.uri)
    params = {amount: amount.to_i,
              amount_currency: from,
              from_account: uuid(from),
              to_account: uuid(to)}
    headers = {'Content-Type' => 'application/x-www-form-urlencoded',
               'X-Api-Key' => api_key}

    request = HTTPI::Request.new
    request.url = url
    request.body = params
    request.headers = headers
    HTTPI.post request
  end

  private

  def uuid(currency)
    Config.uuid(currency)
  end

end
