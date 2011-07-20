# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "html_paginator/version"

Gem::Specification.new do |s|
  s.name        = "html_paginator"
  s.version     = HtmlPaginator::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Theo Cummings"]
  s.email       = "theocummings@gmail.com"
  s.date        = "2011-07-19"
  s.homepage    = "https://github.com/tcummings/html_paginator"
  s.summary     = "Paginates HTML while maintaining the original HTML structure"
  s.description = "Provide a string or HTML and the page size in words, then just call get page and pass in the page number"

  s.require_paths = ["lib"]
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")

  s.add_dependency("nokogiri", ">= 1.4.3.1")
  s.add_dependency("rake")
  
  s.add_development_dependency("rake")
  s.add_development_dependency("rspec", "~> 2.6.0")
end
