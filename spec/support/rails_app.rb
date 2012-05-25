# Provides a Rails application environment to use when running the specs

Rails.env = 'test'

class App < Rails::Application

  configure do
    config.active_support.deprecation = :stderr
    config.logger = Logger.new(STDOUT)
  end

  initialize!

  routes.draw do

    ShopifyAPI.routes self, :referrer => 'referrer'

    namespace :with_only do
      ShopifyAPI.routes self, :only => [:products, :orders]
    end

    namespace :with_except do
      ShopifyAPI.routes self, :except => [:articles, :blogs]
    end

  end

end
