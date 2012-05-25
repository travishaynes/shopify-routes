require 'spec_helper'

describe "route helper methods" do
  before(:all) do
    @router = App.routes
    @domain = "domain.myshopify.com"
  end

  describe "#find_route" do
    context "with a valid name" do
      it "should return a Journey::Route" do
        @router.routes.should_receive(:find).and_return(@router.routes.first)
        # NOTE: the name is not important here, since it's mocked
        find_route("brochure").should be_a Journey::Route
      end
    end

    context "with an invalid name" do
      it "should return nil" do
        find_route("haveyouevernoticedthatweirdalandkennyghavethesamehaircut").should be_nil
      end
    end
  end

  describe "#redirect_for" do
    context "without an id" do
      subject { redirect_for :brochure }
      it      { should eq "http://www.shopify.com?ref=referrer" }
    end

    context "with an id" do
      subject { redirect_for :products, 1 }
      it      { should eq "https://#{@domain}/admin/products/1" }
    end
  end

  describe "#path_for" do
    context "without an id" do
      subject { path_for :a_resource }
      it      { should be_a String }
      it      { should =~ /https:\/\/#{@domain}\/admin\// }
      it      { should =~ /a_resource/ }
      it      { should_not =~ /a_resource\// }
    end
    context "with an id" do
      subject { path_for :a_resource, "with_an_id" }
      it      { should be_a String }
      it      { should =~ /https:\/\/#{@domain}\/admin\// }
      it      { should =~ /a_resource\// }
      it      { should =~ /with_an_id/ }
    end
  end

end
