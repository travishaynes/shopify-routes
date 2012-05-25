# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.authors       = ["Travis Haynes"]
  gem.email         = ["travis.j.haynes@gmail.com"]
  gem.description   = "Provides routes that redirect back to Shopify pages."
  gem.summary       = "Provides routes that redirect back to Shopify pages."
  gem.homepage      = ""

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "shopify-routes"
  gem.require_paths = ["lib"]
  gem.version       = "0.0.4"

  gem.add_runtime_dependency      "rails",                            ">= 3.0.0"
  gem.add_runtime_dependency      "shopify_api",                      ">= 3.0.0"
  gem.add_development_dependency  "rspec-rails",                      "~> 2.9.0"
end
