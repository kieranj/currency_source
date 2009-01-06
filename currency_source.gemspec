Gem::Specification.new do |s|
  s.name = 'currency_source'
  s.version = '0.0.1'
  s.summary = 'Fetches exchange rates from Currency Source'
  s.email    = "kieran[AT]invisiblelines.com"
  s.homepage = "http://github.com/kieranj/currency_source"
  s.rubyforge_project = "currency_source"
  s.description = "Ruby library for fetching exchange rates from currency source"
  s.has_rdoc = true
  s.authors = [ 'Kieran Johnson' ]
  s.add_dependency('hpricot')
  s.files = [
    "history.txt",
    "license.txt",
    "lib/currency_source.rb",
    "lib/currency_source/currency.rb",
    "README.rdoc"
  ]
  s.test_files = [
    "spec/currency_spec.rb",
  ]
  s.rdoc_options = ["--main", "Readme.rdoc"]
  s.extra_rdoc_files = ["Readme.rdoc"]
end