require File.dirname(__FILE__) + '/spec_helper'

module CurrencySource
  
  describe Currency do
      
      before do
        @currency = Currency.new("GBP")
        @currency.stub!(:open).and_return(open(File.dirname(__FILE__) + "/fixtures/GBP.xml"))
      end
      
      it "should only except listed currencies" do
        Currencies::ValidCurrencies.should include("GBP")
      end
    
      it "should not except unlisted currencies" do
        lambda { Currency.new("ABC") }.should raise_error(InvalidCurrency)
      end
    
      it "should fetch the latest exchange rates for assigned currency" do
        @currency.should_receive(:open).with("http://www.currencysource.com/rss/GBP.xml")
        @currency.exchange_rate("USD")
      end
      
      it "should have a hash of exchange rates" do
        @currency.exchange_rates.should be_instance_of(Hash)
      end
      
      it "should return the exchange rate" do
        @currency.exchange_rate("USD").should match(/\d+\.\d+/)
      end
      
      it "should raise MissingExchangeRate for missing key" do
        lambda { @currency.exchange_rate("ZED") }.should raise_error(MissingExchangeRate)
      end
    
  end
  
end