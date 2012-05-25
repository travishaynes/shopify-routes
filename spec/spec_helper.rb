require 'rails'
require "action_controller/railtie"
require 'shopify-routes'

# load the support files
Dir["spec/support/**/*.rb"].each { |f| require File.expand_path(f) }

require 'rspec/rails'
