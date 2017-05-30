require 'net/http'
require 'uri'
# require 'openssl'
# require 'httparty'
# require 'httpi'
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
  def exchange_transfer(amount, from, to)
    uri = URI(Config.uri)
    @request = Net::HTTP::Post.new(uri.path)

    params = {amount: amount.to_i,
              amount_currency: from,
              from_account: Config.uuid(from),
              to_account: Config.uuid(to)}

    @request.set_form_data(parameters: params)
    @request['Content Type'] = 'application/x-www-form-urlencoded'
    @request['X-Api-Key'] = Config.auth_key


    @response = Net::HTTP.start(uri.hostname, 443,
                                use_ssl: uri.scheme == 'https') do |https|
      puts https.use_ssl?
      https.request @request
    end
  end

  # def log_request
  #   puts '---------'
  #   puts 'REQUEST:'
  #   puts @request.headers
  #   puts @request.body
  # end

  def log_response
    puts '---------'
    puts 'RESPONSE:'
    puts @response.code
    puts @response.class.name
  end

  # parsing response & get data for tests
  def response
  end

end


# httparty:
# url = URI(Config.uri)
# body = {amount: amount.to_i,
#         amount_currency: from,
#         from_account: Config.uuid(from),
#         to_account: Config.uuid(to)}
# headers = {'Content Type' => 'application/x-www-form-urlencoded',
#            'X-Api-Key' => Config.auth_key}
# @response = HTTParty.post(url, headers: headers, parameters: body, verify: false)


# # httpi
# def transaction(amount, from, to)
#   @request = HTTPI::Request.new
#   @request.auth.basic('qaguard0001@mailinator.com', 'g3tt3stsd0ne')
#   @request.auth.ssl.verify_mode = :none
#   @request.url = URI(Config.uri)
#   @request.body = {amount: amount.to_i,
#                    amount_currency: from,
#                    from_account: Config.uuid(from),
#                    to_account: Config.uuid(to)}
#   @request.headers = {'Content Type' => 'application/x-www-form-urlencoded',
#                       'X-Api-Key' => Config.auth_key}
#   @response = HTTPI.post(@request)
# end
