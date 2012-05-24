# Shopify.routes

Provides routes that redirect back to Shopify pages.

## Installation

Add this line to your application's Gemfile:

    gem 'shopify-routes'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install shopify-routes

## Usage

Adding the routes to your app is dead simple. All you need to do is add a single
line of code to your `config/routes.rb` file. However, it's highly recommended
that you add your routes to a namespace to prevent conflicts with your
application. Here's an example of how to add all the Shopify routes under a
`:shopify` namespace:

    MyApp::Application.routes.draw do
      namespace :shopify do
        ShopifyAPI::Routes.draw(self)
      end
    end

You can also specify which routes you want to include, or exclude, as you would
normally with a Rails resource:

    ShopifyAPI::Routes.draw self, only: [ :orders, :products ]
    ShopifyAPI::Routes.draw self, except: [ :articles, :blogs ]

To include a referrer ID for the `:signup` and `:brochure` pages, add a
`:referrer` option to the routes:

    ShopifyAPI::Routes.draw self, :referrer => "travishaynes"

The above example would route `shopify_brochure_path` to
[http://www.shopify.com?ref=travishaynes](http://www.shopify.com?ref=travishaynes),
and `shopify_signup_path` to
[https://app.shopify.com/services/signup?ref=travishaynes](https://app.shopify.com/services/signup?ref=travishaynes).

## Routes

For all except the brochure and signup pages, you'll have to include the shop's
domain in the url helper. For example:

    orders_url(:shop => "my-shopify-domain")

Or for redirecting to a specific order:

    order_url(:shop => "my-shopify-domain", :id => 1001)

Here's a list of all the routes that will be added to your app, outside of any
namespace to keep things simple.

                      brochure        /
                        signup        /signup(.:format)
                         admin        /:shop/admin(.:format)
                  applications        /:shop/admin/applications(.:format)
                        orders        /:shop/admin/orders(.:format)
                         order        /:shop/admin/orders/:id(.:format)
                     customers        /:shop/admin/customers(.:format)
                      customer        /:shop/admin/customers/:id(.:format)
                  new_customer        /:shop/admin/customers/new(.:format)
                      products        /:shop/admin/products(.:format)
                       product        /:shop/admin/products/:id(.:format)
                   new_product        /:shop/admin/products/new(.:format)
            custom_collections        /:shop/admin/custom_collections(.:format)
             custom_collection        /:shop/admin/custom_collections/:id(.:format)
         new_custom_collection        /:shop/admin/custom_collections/new(.:format)
             smart_collections        /:shop/admin/smart_collections(.:format)
              smart_collection        /:shop/admin/smart_collections/:id(.:format)
          new_smart_collection        /:shop/admin/smart_collections/new(.:format)
                         pages        /:shop/admin/pages(.:format)
                          page        /:shop/admin/pages/:id(.:format)
                      new_page        /:shop/admin/pages/new(.:format)
                         blogs        /:shop/admin/blogs(.:format)
                          blog        /:shop/admin/blogs/:id(.:format)
                      new_blog        /:shop/admin/blogs/new(.:format)
                    navigation        /:shop/admin/links(.:format)
                    promotions        /:shop/admin/marketing(.:format)
                        themes        /:shop/admin/themes(.:format)
                         theme        /:shop/admin/themes/:id(.:format)
                theme_settings        /:shop/admin/themes:id/settings(.:format)
              general_settings        /:shop/admin/general_preferences(.:format)
                       regions        /:shop/admin/countries(.:format)
                        region        /:shop/admin/countries/:id(.:format)
                    new_region        /:shop/admin/countries/new(.:format)
          checkout_and_payment        /:shop/admin/payments(.:format)
                shipping_rates        /:shop/admin/shipping(.:format)
    weight_based_shipping_rate        /:shop/admin/weight_based_shipping_rates/:id(.:format)
     price_based_shipping_rate        /:shop/admin/price_based_shipping_rates/:id(.:format)
          fulfillment_services        /:shop/admin/fulfillment_services(.:format)
                 notifications        /:shop/admin/notifications(.:format)
                  notification        /:shop/admin/notifications/:id(.:format)
                       domains        /:shop/admin/domains(.:format)


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
