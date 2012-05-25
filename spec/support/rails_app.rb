require 'rails'
require "action_controller/railtie"

module RailsApp
  # Provides a Rails application environment to use when running the specs
  class Application < Rails::Application
    config.encoding = 'utf-8'
  end

  Application.configure do
    config.active_support.deprecation = :stderr
    config.logger = Logger.new(STDOUT)
  end
end

Rails.env = 'test'
RailsApp::Application.initialize!

RailsApp::Application.routes.draw do
  ShopifyAPI.routes(self)
end
