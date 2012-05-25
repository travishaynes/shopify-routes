require 'spec_helper'

describe "ShopifyAPI.routes" do
  before do
    @router = RailsApp::Application.routes
    @domain = "domain.myshopify.com"
  end

  def find_route(name)
    @router.routes.find {|r| r.name == name }
  end

  def redirect_for(resource, id = nil)
    route   = find_route(resource)
    params  = { :shop => @domain }
    params[:id] = id unless id.nil?
    route.app.path(params, nil)
  end

  def path_for(resource, id = nil)
    path = "https://#{@domain}/admin/#{resource}"
    path += "/#{id}" unless id.nil?
    path
  end

  describe "redirect routes" do

    describe "applications" do
      subject { redirect_for "applications" }
      it      { should eq path_for "applications" }
    end

    describe "orders" do
      subject { redirect_for "orders" }
      it      { should eq path_for "orders" }
    end

    describe "order" do
      subject { redirect_for "order", "1" }
      it      { should eq path_for "orders", "1" }
    end

    describe "customers" do
      subject { redirect_for "customers" }
      it      { should eq path_for "customers" }
    end

    describe "customer" do
      subject { redirect_for "customer", "1" }
      it      { should eq path_for "customers", "1" }
    end

    describe "new_customer" do
      subject { redirect_for "new_customer" }
      it      { should eq path_for "customers", "new" }
    end

    describe "products" do
      subject { redirect_for "products" }
      it      { should eq path_for "products" }
    end

    describe "product" do
      subject { redirect_for "product", "1" }
      it      { should eq path_for "products", "1" }
    end

    describe "new_product" do
      subject { redirect_for "new_product" }
      it      { should eq path_for "products", "new" }
    end

    describe "custom_collections" do
      subject { redirect_for "custom_collections" }
      it      { should eq path_for "custom_collections" }
    end

    describe "custom_collection" do
      subject { redirect_for "custom_collection", "1" }
      it      { should eq path_for "custom_collections", "1" }
    end

    describe "new_custom_collection" do
      subject { redirect_for "new_custom_collection" }
      it      { should eq path_for "custom_collections", "new" }
    end

    describe "smart_collections" do
      subject { redirect_for "smart_collections" }
      it      { should eq path_for "smart_collections" }
    end

    describe "smart_collection" do
      subject { redirect_for "smart_collection", "1" }
      it      { should eq path_for "smart_collections", "1" }
    end

    describe "new_smart_collection" do
      subject { redirect_for "new_smart_collection" }
      it      { should eq path_for "smart_collections", "new" }
    end

    describe "pages" do
      subject { redirect_for "pages" }
      it      { should eq path_for "pages" }
    end

    describe "page" do
      subject { redirect_for "page", "1" }
      it      { should eq path_for "pages", "1" }
    end

    describe "new_page" do
      subject { redirect_for "new_page" }
      it      { should eq path_for "pages", "new" }
    end

    describe "blogs" do
      subject { redirect_for "blogs" }
      it      { should eq path_for "blogs" }
    end

    describe "blog" do
      subject { redirect_for "blog", "1" }
      it      { should eq path_for "blogs", "1" }
    end

    describe "new_blog" do
      subject { redirect_for "new_blog" }
      it      { should eq path_for "blogs", "new" }
    end

    describe "navigation" do
      subject { redirect_for "navigation" }
      it      { should eq path_for "links" }
    end

    describe "promotions" do
      subject { redirect_for "promotions" }
      it      { should eq path_for "marketing" }
    end

    describe "themes" do
      subject { redirect_for "themes" }
      it      { should eq path_for "themes" }
    end

    describe "theme" do
      subject { redirect_for "theme", "1" }
      it      { should eq path_for "themes", "1" }
    end

    describe "theme_settings" do
      subject { redirect_for "theme_settings", "1" }
      it      { should eq path_for "themes/1/settings" }
    end

    describe "general_settings" do
      subject { redirect_for "general_settings" }
      it      { should eq path_for "general_preferences" }
    end

    describe "regions" do
      subject { redirect_for "regions" }
      it      { should eq path_for "countries" }
    end

    describe "checkout_and_payment" do
      subject { redirect_for "checkout_and_payment" }
      it      { should eq path_for "payments" }
    end

    describe "shipping_rates" do
      subject { redirect_for "shipping_rates" }
      it      { should eq path_for "shipping" }
    end

    describe "weight_based_shipping_rate" do
      subject { redirect_for "weight_based_shipping_rate", "1" }
      it      { should eq path_for "weight_based_shipping_rates", "1" }
    end

    describe "price_based_shipping_rate" do
      subject { redirect_for "price_based_shipping_rate", "1" }
      it      { should eq path_for "price_based_shipping_rates", "1" }
    end

    describe "fulfillment_services" do
      subject { redirect_for "fulfillment_services" }
      it      { should eq path_for "fulfillment_services" }
    end

    describe "notifications" do
      subject { redirect_for "notifications" }
      it      { should eq path_for "notifications" }
    end

    describe "notification" do
      subject { redirect_for "notification", "1" }
      it      { should eq path_for "notifications", "1" }
    end

    describe "domains" do
      subject { redirect_for "domains" }
      it      { should eq path_for "domains" }
    end
  end
end
