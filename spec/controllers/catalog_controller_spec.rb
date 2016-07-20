require 'rails_helper'

RSpec.describe CatalogController, type: :controller do

  describe "GET #show" do
    it "returns http success" do
      get :view
    end

    it "it shows product on catalog view" do
      category = FactoryGirl.create(:category)
      product = FactoryGirl.create(:product, category_id: category.id)
      get :view
      assigns(:products).should eq([product])
    end
  end

end
