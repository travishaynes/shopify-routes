require 'shopify_api'

module ShopifyAPI
  class << self
    # use this in your `config/routes.rb` file to draw the Shopify routes
    # @param [ActionDispatch::Routing::RouteSet] router The router
    # @param [Hash] options The options for drawing the routes
    # @option options [String] :referrer Your Shopify Partner referrer ID
    # @option options [Array] :only An Array of resources to included in the routes
    # @option options [Array] :except An Array of resources to exclude from the routes
    # @example Draw all the Shopify routes
    #     MyApp::Application.routes.draw do
    #       ShopifyAPI::Routes.draw(self)
    #     end
    # @example Drawing only the Products and Orders routes
    #     MyApp::Application.routes.draw do
    #       ShopifyAPI::Routes.draw self, only: [:products, :orders]
    #     end
    # @example Drawing every route except for :custom_collections
    #     MyApp::Application.routes.draw do
    #       ShopifyAPI::Routes.draw self, except: [:custom_collections]
    #     end
    # @example Including a referrer ID
    #     MyApp::Application.routes.draw do
    #       ShopifyAPI::Routes.draw self, referrer: "travishaynes"
    #     end
    # @api public
    def routes(router, options = {})
      # cache the router
      @router = router

      # extract the referrer from the options, if it's included
      @ref = "?ref=#{options[:referrer]}" if options.include? :referrer

      # default namespace
      options[:namespace] ||= :shopify

      # extract the :only, or :except options, if they're included
      @only = Array(options[:only]) if options.include?(:only)
      @except = Array(options[:except]) if options.include?(:except)

      # draw the routes
      draw
    end

    private

    # ensures a shop domain is suffixed with ".myshopify.com"
    # @param [String] shop The shop's domain, with or without ".myshopify.com"
    # @return [String] The shop's domain with ".myshopify.com"
    # @api private
    def shop_domain(shop)
      shop =~ /.*myshopify\.com/ ? shop : shop + ".myshopify.com"
    end


    # draws a route for the given path, actions and alias
    # @param [String] path The path for the route
    # @param [Array] actions List of actions to draw for this route
    # @param [String] nom Alias for the route if the path name does not suffice
    # @api private
    def match(path, actions, nom = path)

      # only draw this route if it's included
      return unless include?(path)

      actions.each do |action|

        # create the route, and it's name
        route = ":shop/admin/#{path.to_s}"
        name  = nom.to_s

        case action

        # route for show
        when :show
          route << "/:id"
          name = name.singularize

        # route for new
        when :new
          route << "/new"
          name = "new_#{name.singularize}"

        # custom routes
        else
          unless action == :index
            route << action
            action = ""
          end
        end

        # draw the route
        match_admin_path(
          route       => name,
          :action     => action,
          :controller => "shopify_#{nom.to_s.pluralize}"
        )
      end

    end


    # generates a path to a resource in the Shopify namespace
    # @param [String] path The path to match
    # @param [String] resource The name of the resource - plural or singular
    # @param [ActionDispatch::Routing::RouteSet] The router to add the matches
    # @api private
    def match_admin_path(options = {})

      # use the router from the options, or the cached one
      router = options[:router] || @router

      # get the path and resource
      path, resource = options.first

      # default to using the resource for the named route
      options[:as] ||= resource

      # generate the match route
      router.match path => router.redirect { |params, r|

        # ensure the ".myshopify.com" suffix exists
        shop = shop_domain(params[:shop])

        # path to the shop's admin resource
        uri = "https://#{shop}/admin/#{resource}"

        # check if we need to include an id
        uri << "/#{params[:id]}" if params.include?(:id)

        # return the redirect URI
        uri
      },

      :as         => options[:as],
      :action     => options[:action],
      :controller => options[:controller]

    end


    # checks if a resource should be included in the routes
    # @param [Symbol] name The name of the resource
    # @return [Boolean] true when it should be included
    # @api private
    def include?(name)
      (@only.nil? && @except.nil?) ||
      (!@only.nil? && @only.include?(name)) ||
      (!@except.nil? && !@except.include?(name))
    end


    # draws the Shopify routes
    # @param [ActionDispatch::Routing::RouteSet] r The router
    # @api private
    def draw(r = @router)

      if include?(:brochure)
        # route to the Shopify brochure path
        brochure_path = "http://www.shopify.com#{@ref}"
        r.match(
          "/"           => r.redirect(brochure_path),
          :as           => "brochure",
          :controller   => "shopify",
          :action       => "index"
        )
      end

      if include?(:signup)
        # route to the Shopify sign up path
        signup_path = "https://app.shopify.com/services/signup#{@ref}"
        r.match(
          "signup"      => r.redirect(signup_path),
          :as           => "signup",
          :controller   => "shopify",
          :action       => "signup"
        )
      end

      if include?(:admin)
        # route to a shop's admin path
        r.match ":shop/admin" => r.redirect { |p,r|
            "https://#{p[:shop]}.myshopify.com/admin"
          },
          :as         => "admin",
          :controller => "shopify_admin",
          :action     => "index"
      end

      # draw the routes
      match :applications,                [:index]
      match :orders,                      [:index, :show]
      match :customers,                   [:index, :show, :new]
      match :products,                    [:index, :show, :new]
      match :custom_collections,          [:index, :show, :new]
      match :smart_collections,           [:index, :show, :new]
      match :pages,                       [:index, :show, :new]
      match :blogs,                       [:index, :show, :new]
      match :links,                       [:index],               "navigation"
      match :marketing,                   [:index],               "promotions"
      match :themes,                      [:index, :show]
      match :themes,                      [":id/settings"],       "theme_settings"
      match :general_preferences,         [:index],               "general_settings"
      match :countries,                   [:index, :show, :new],  "regions"
      match :payments,                    [:index],               "checkout_and_payment"
      match :shipping,                    [:index],               "shipping_rates"
      match :weight_based_shipping_rates, [:show]
      match :price_based_shipping_rates,  [:show]
      match :fulfillment_services,        [:index]
      match :notifications,               [:index, :show]
      match :domains,                     [:index]
    end
  end
end
