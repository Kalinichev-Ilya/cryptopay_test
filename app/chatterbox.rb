# require 'net/http'
# require 'httparty'
require 'httpi'
require 'yaml'
require_relative 'config'

# 'amount': сумма перевода,
# 'amount_currency': валюта поля Amount в формате BTC\EUR\USD\GBP,
# 'from_account': UUID аккаунта пользователя, с которого делается перевод,
# 'to_account': UUID аккаунта пользователя, на который делается перевод.
class Chatterbox

  # amount: the number of transferred funds
  # from: currency from_account which the transaction is made 'Ex. :BTC'
  # to: currency to_account to which the transaction is made 'Ex :EUR'
  def transaction(amount, from, to)
    @request = HTTPI::Request.new
    @request.url = URI(Config.uri)
    @request.body = {amount: amount.to_i,
                     amount_currency: from,
                     from_account: Config.uuid(from),
                     to_account: Config.uuid(to)}
    @request.headers = {'Content Type' => 'application/x-www-form-urlencoded',
                        'X-Api-Key' => Config.auth_key}
    @response = HTTPI.post(@request)
  end

  def log_request
    puts '---------'
    puts 'REQUEST:'
    puts @request.headers
    puts @request.body
  end

  def log_response
    puts '---------'
    puts 'RESPONSE:'
    puts @response.code
    puts @response.headers
    puts @response.body
  end

  # parsing response & get data for tests
  def response
  end

end


# old version:
#
# res = HTTParty.post(uri, headers: head, parameters: params)
#
# # res.response.body.split(',').to_a.each {|el| puts el}
# # res = HTTParty.post(uri, headers: {'Content Type' => 'application/x-www-form-urlencoded; charset=UTF-8', 'X-Api-Key' => 'acea9d6d570540bb7d0e0f077182ffdc'},
# #                     params: {'amount_currency' => 'USD',
# #                              'amount' => '0.1',
# #                              'from_account' => 'd96d23be-30c9-4243-a9ab-e432e9a6f71d',
# #                              'to_account' => '95b22bb7-1bee-4bc5-9555-52689137eb49'})
# puts res.response.body
