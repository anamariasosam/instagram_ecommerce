require 'rails_helper'

RSpec.describe StoresController, type: :controller do

  describe "GET #show" do
    it "returns http success" do
      get :show
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

end
