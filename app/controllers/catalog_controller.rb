class CatalogController < ApplicationController
  def view
    @catalog_products = Product.page(params[:page]).per(6).order('user_id asc')
  end
end
