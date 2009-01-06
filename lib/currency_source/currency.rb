require "rubygems"
require "hpricot"
require "open-uri"

module CurrencySource
  
  class InvalidCurrency < StandardError; end
  
  class Currency
    
    ValidCurrencies = [
      'ARS',
      'AUD',
      'BHD',
      'BWP',
      'BRL',
      'BND',
      'CAD',
      'CLP',
      'CNY',
      'COP',
      'CZK',
      'DKK',
      'EUR',
      'HUF',
      'ISK',
      'INR',
      'IDR',
      'IRR',
      'ILS',
      'JPY',
      'KRW',
      'KWD',
      'LYD',
      'MYR',
      'MUR',
      'MXN',
      'NPR',
      'NZD',
      'NOK',
      'OMR',
      'PKR',
      'PLN',
      'GBP',
      'QAR',
      'SAR',
      'SGD',
      'SIT',
      'ZAR',
      'LKR',
      'SEK',
      'CHF',
      'THB',
      'TTD',
      'AED',
      'USD',
      'VEB'
    ]

    BaseURL = "http://www.currencysource.com/rss/"
    
    attr_reader :currency
    
    def initialize(currency)
      raise InvalidCurrency unless ValidCurrencies.include?(currency)
      @currency       = currency
    end
    
    def exchange_rate(other_currency)
      raise InvalidCurrency unless ValidCurrencies.include?(currency)
      exchange_rates[other_currency] rescue ""
    end
    
    def exchange_rates
      @exchange_rates ||= parse_exchange_rates
    end
      
    private
      
      def doc
        @doc ||= Hpricot(open(BaseURL + @currency + ".xml"))
      end
      
      def parse_exchange_rates
        doc.search("//item/title").inject({}) do |result, item|
          i = item.inner_html
          input, output, v1, v2 = i.match(/\d\s(\S{3}) = (\S{3}) \((\d+,\d+|\d+)(\.\d{2})/).captures
          result[output] = v1 + v2
          result
        end
      end
    
  end
  
end