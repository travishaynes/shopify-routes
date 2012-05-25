require 'spec_helper'

describe "ShopifyAPI.routes" do
  before do
    @router = RailsApp::Application.routes
    @domain = "domain.myshopify.com"
  end

  context "with the :only option" do
    before do
      @routes = @router.routes.collect {|r|
          r.name.gsub("with_only_", "") if r.name =~ /with_only_.*/
        }.compact
    end

    subject { @routes }

    it { should include "products" }
    it { should include "product" }
    it { should include "new_product" }
    it { should include "orders" }
    it { should include "order" }

    it { should_not include "articles" }
    it { should_not include "article" }
    it { should_not include "new_article" }
    it { should_not include "blogs" }
    it { should_not include "blog" }
    it { should_not include "new_blog" }
    it { should_not include "brochure" }
    it { should_not include "signup" }
    it { should_not include "admin" }
    it { should_not include "applications" }
    it { should_not include "customers" }
    it { should_not include "customer" }
    it { should_not include "new_customer" }
    it { should_not include "custom_collections" }
    it { should_not include "custom_collection" }
    it { should_not include "new_custom_collection" }
    it { should_not include "smart_collections" }
    it { should_not include "smart_collection" }
    it { should_not include "new_smart_collection" }
    it { should_not include "pages" }
    it { should_not include "page" }
    it { should_not include "new_page" }
    it { should_not include "navigation" }
    it { should_not include "promotions" }
    it { should_not include "themes" }
    it { should_not include "theme" }
    it { should_not include "theme_settings" }
    it { should_not include "general_settings" }
    it { should_not include "regions" }
    it { should_not include "region" }
    it { should_not include "new_region" }
    it { should_not include "checkout_and_payment" }
    it { should_not include "shipping_rates" }
    it { should_not include "weight_based_shipping_rate" }
    it { should_not include "price_based_shipping_rate" }
    it { should_not include "fulfillment_services" }
    it { should_not include "notifications" }
    it { should_not include "notification" }
    it { should_not include "domains" }
  end

  context "with the :except option" do
    before do
      @routes = @router.routes.collect {|r|
          r.name.gsub("with_except_", "") if r.name =~ /with_except_.*/
        }.compact
    end

    subject { @routes }

    it { should_not include "articles" }
    it { should_not include "article" }
    it { should_not include "new_article" }
    it { should_not include "blogs" }
    it { should_not include "blog" }
    it { should_not include "new_blog" }

    it { should include "brochure" }
    it { should include "signup" }
    it { should include "admin" }
    it { should include "applications" }
    it { should include "orders" }
    it { should include "order" }
    it { should include "customers" }
    it { should include "customer" }
    it { should include "new_customer" }
    it { should include "products" }
    it { should include "product" }
    it { should include "new_product" }
    it { should include "custom_collections" }
    it { should include "custom_collection" }
    it { should include "new_custom_collection" }
    it { should include "smart_collections" }
    it { should include "smart_collection" }
    it { should include "new_smart_collection" }
    it { should include "pages" }
    it { should include "page" }
    it { should include "new_page" }
    it { should include "navigation" }
    it { should include "promotions" }
    it { should include "themes" }
    it { should include "theme" }
    it { should include "theme_settings" }
    it { should include "general_settings" }
    it { should include "regions" }
    it { should include "region" }
    it { should include "new_region" }
    it { should include "checkout_and_payment" }
    it { should include "shipping_rates" }
    it { should include "weight_based_shipping_rate" }
    it { should include "price_based_shipping_rate" }
    it { should include "fulfillment_services" }
    it { should include "notifications" }
    it { should include "notification" }
    it { should include "domains" }
  end

  context "all routes" do
    describe "brochure" do
      subject { redirect_for :brochure }
      it      { should eq "http://www.shopify.com?ref=referrer" }
    end

    describe "signup" do
      subject { redirect_for :signup }
      it      { should eq "https://app.shopify.com/services/signup?ref=referrer" }
    end

    describe "admin" do
      subject { redirect_for :admin }
      it      { should eq "https://#{@domain}/admin" }
    end

    describe "applications" do
      subject { redirect_for :applications }
      it      { should eq path_for :applications }
    end

    describe "orders" do
      subject { redirect_for :orders }
      it      { should eq path_for :orders }
    end

    describe "order" do
      subject { redirect_for :order, 1 }
      it      { should eq path_for :orders, "1" }
    end

    describe "customers" do
      subject { redirect_for :customers }
      it      { should eq path_for :customers }
    end

    describe "customer" do
      subject { redirect_for :customer, "1" }
      it      { should eq path_for :customers, "1" }
    end

    describe "new_customer" do
      subject { redirect_for :new_customer }
      it      { should eq path_for :customers, "new" }
    end

    describe "products" do
      subject { redirect_for :products }
      it      { should eq path_for :products }
    end

    describe "product" do
      subject { redirect_for :product, 1 }
      it      { should eq path_for :products, 1 }
    end

    describe "new_product" do
      subject { redirect_for :new_product }
      it      { should eq path_for :products, "new" }
    end

    describe "custom_collections" do
      subject { redirect_for :custom_collections }
      it      { should eq path_for :custom_collections }
    end

    describe "custom_collection" do
      subject { redirect_for :custom_collection, 1 }
      it      { should eq path_for :custom_collections, "1" }
    end

    describe "new_custom_collection" do
      subject { redirect_for :new_custom_collection }
      it      { should eq path_for :custom_collections, "new" }
    end

    describe "smart_collections" do
      subject { redirect_for :smart_collections }
      it      { should eq path_for :smart_collections }
    end

    describe "smart_collection" do
      subject { redirect_for :smart_collection, 1 }
      it      { should eq path_for :smart_collections, "1" }
    end

    describe "new_smart_collection" do
      subject { redirect_for :new_smart_collection }
      it      { should eq path_for :smart_collections, "new" }
    end

    describe "pages" do
      subject { redirect_for :pages }
      it      { should eq path_for :pages }
    end

    describe "page" do
      subject { redirect_for :page, 1 }
      it      { should eq path_for :pages, "1" }
    end

    describe "new_page" do
      subject { redirect_for :new_page }
      it      { should eq path_for :pages, "new" }
    end

    describe "blogs" do
      subject { redirect_for :blogs }
      it      { should eq path_for :blogs }
    end

    describe "blog" do
      subject { redirect_for :blog, 1 }
      it      { should eq path_for :blogs, "1" }
    end

    describe "new_blog" do
      subject { redirect_for :new_blog }
      it      { should eq path_for :blogs, "new" }
    end

    describe "navigation" do
      subject { redirect_for :navigation }
      it      { should eq path_for :links }
    end

    describe "promotions" do
      subject { redirect_for :promotions }
      it      { should eq path_for :marketing }
    end

    describe "themes" do
      subject { redirect_for :themes }
      it      { should eq path_for :themes }
    end

    describe "theme" do
      subject { redirect_for :theme, 1 }
      it      { should eq path_for :themes, "1" }
    end

    describe "theme_settings" do
      subject { redirect_for :theme_settings, "1" }
      it      { should eq path_for "themes/1/settings" }
    end

    describe "general_settings" do
      subject { redirect_for :general_settings }
      it      { should eq path_for :general_preferences }
    end

    describe "regions" do
      subject { redirect_for :regions }
      it      { should eq path_for :countries }
    end

    describe "checkout_and_payment" do
      subject { redirect_for :checkout_and_payment }
      it      { should eq path_for :payments }
    end

    describe "shipping_rates" do
      subject { redirect_for :shipping_rates }
      it      { should eq path_for :shipping }
    end

    describe "weight_based_shipping_rate" do
      subject { redirect_for :weight_based_shipping_rate, 1 }
      it      { should eq path_for :weight_based_shipping_rates, "1" }
    end

    describe "price_based_shipping_rate" do
      subject { redirect_for :price_based_shipping_rate, 1 }
      it      { should eq path_for :price_based_shipping_rates, "1" }
    end

    describe "fulfillment_services" do
      subject { redirect_for :fulfillment_services }
      it      { should eq path_for :fulfillment_services }
    end

    describe "notifications" do
      subject { redirect_for :notifications }
      it      { should eq path_for :notifications }
    end

    describe "notification" do
      subject { redirect_for :notification, 1 }
      it      { should eq path_for :notifications, "1" }
    end

    describe "domains" do
      subject { redirect_for :domains }
      it      { should eq path_for :domains }
    end
  end
end
