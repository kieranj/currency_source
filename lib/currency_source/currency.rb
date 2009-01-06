module CurrencySource
  
  Version = "0.0.1"
  
  class InvalidCurrency < StandardError; end
  class MissingExchangeRate < StandardError; end
  
  class Currency

    BaseURL = "http://www.currencysource.com/rss/"
    
    attr_reader :currency
    
    def initialize(currency)
      raise InvalidCurrency unless Currencies::ValidCurrencies.include?(currency)
      @currency = currency
    end
    
    def exchange_rate(other_currency)
      raise InvalidCurrency unless Currencies::ValidCurrencies.include?(currency)
      raise MissingExchangeRate unless exchange_rates.keys.include?(other_currency)
      exchange_rates[other_currency] 
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