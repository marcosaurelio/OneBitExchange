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
    if !(@source_currency + @target_currency).index(/BTC/)
      exchange_api_url = Rails.application.credentials[:currency_api_url]
      exchange_api_key = Rails.application.credentials[:currency_api_key]
      url = "#{exchange_api_url}?token=#{exchange_api_key}&currency=#{@source_currency}/#{@target_currency}"
      res = RestClient.get url
      JSON.parse(res.body)['currency'][0]['value'].to_f
    else
      url = 'https://bitpay.com/api/rates'
      res = RestClient.get url
      if @source_currency == 'BTC'
        (@amount.to_f * JSON.parse(res.body).find { |r| r['code'] =~ /#{@target_currency}/ }['rate']).round(10)
      else
        (@amount.to_f / JSON.parse(res.body).find { |r| r['code'] =~ /#{@source_currency}/ }['rate']).round(10)
      end
    end
  end

end
