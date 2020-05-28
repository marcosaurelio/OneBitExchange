require 'rest-client'
require 'json'

class ExchangeService

  def initialize(source_currency, target_currency, amount)
    @source_currency = source_currency
    @target_currency = target_currency
    @amount = amount
  end

  def call
    begin
      value = get_exchange
      value * @amount.to_f
    rescue ResClient::ExceptionWithResponse => e
      e.response
    end
  end

  private

  def get_exchange
    if @target_currency == 'BTC'
      url = "https://blockchain.info/tobtc?currency=#{@source_currency}&value=#{@amount}"
      res = RestClient.get url
      res.to_s.to_f
    else
      exchange_api_url = Rails.application.credentials[:currency_api_url]
      exchange_api_key = Rails.application.credentials[:currency_api_key]
      url = "#{exchange_api_url}?token=#{exchange_api_key}&currency=#{@source_currency}/#{@target_currency}"
      res = RestClient.get url
      JSON.parse(res.body)['currency'][0]['value'].to_f
    end
  end

end

# from = 'BTC'
# to = 'GBP'
# amount = '10'

# url = 'http://api.coinlayer.com/api/live?access_key=671e23e31c19649c8ab5a4a9dfd2d5b1' +  +'&from=' + from + '&to=' + to + '&amount=' + amount

# JSON.parse(res.body)['target']
# JSON.parse(res.body)['rates']

# https://blockchain.info/tobtc?currency=BRL&value=1