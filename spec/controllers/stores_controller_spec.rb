require 'rails_helper'

RSpec.describe StoresController, type: :controller do

  describe "GET #show" do

    it "assigns the requested product to @store" do
      store = FactoryGirl.create(:store)
      get :show, id: store
      assigns(:store).should eq(store)
    end


    it "renders the #show template" do
      get :show, id: FactoryGirl.create(:store)
      response.should render_template :show
    end
  end

end
