require 'rails_helper'

RSpec.describe ProductsController, type: :controller do

  describe "GET #show" do

    it "assigns the requested product to @product" do
      category = FactoryGirl.create(:category)
      product = FactoryGirl.create(:product, category_id: category.id)
      get :show, id: product.id
      assigns(:product).should eq(product)
    end


    it "renders the #show view" do
      category = FactoryGirl.create(:category)
      product = FactoryGirl.create(:product, category_id: category.id)
      get :show, id: product.id
      response.should render_template :show

    end
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
    end

    it "it shows product on products index" do
      category = FactoryGirl.create(:category)
      product = FactoryGirl.create(:product, category_id: category.id)
      get :index
      assigns(:products).should eq([product])
    end
  end


end
