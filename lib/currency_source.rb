module CurrencySource
  
  %w(currency currencies version).each do |lib|
     require File.join(File.dirname(__FILE__), 'currency_source', lib)
  end
  
end