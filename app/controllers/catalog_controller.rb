class CatalogController < ApplicationController
  def view
    @products = Product.all.order('user_id asc')
    @cover_products = Product.limit(6)
    @catalog_products = Product.page(params[:page]).per(6).order('user_id asc')
  end
end
