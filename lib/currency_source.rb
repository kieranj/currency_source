module CurrencySource
  
  require "rubygems"
  require "hpricot"
  require "open-uri"
  
  %w(currency currencies version).each do |lib|
     require File.join(File.dirname(__FILE__), 'currency_source', lib)
  end
  
end