require 'rails_helper'

RSpec.describe ProductsController, type: :controller do

  describe "GET #show" do
    it "renders the #show view" do
      product = FactoryGirl.create(:product)
      get :show, {id: product.id}
      response.should render_template :show
    end
  end

  describe "GET #index" do
    it "assigns @products" do
      product = FactoryGirl.create(:product)
      get :index
      expect(assigns(:products)).to eq([product])
    end

    it "loads all of the products into @products" do
      product1 FactoryGirl.create(:product)
      product2 = FactoryGirl.create(:product)
      get :index

      expect(assigns(:products)).to match_array([product1, product2])
    end
  end
end
