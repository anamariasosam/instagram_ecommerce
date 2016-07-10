require 'rails_helper'

RSpec.describe "ProductShows", type: :request do
  describe "GET /product_shows" do

    it "show the product page" do
      user = FactoryGirl.create(:user)
      category = FactoryGirl.create(:category)
      product = FactoryGirl.create(:product)

      visit '/products/' + product.id.to_s

      expect(page).to have_title product.product_name + " - Catlog"

    end
  end
end
