class CatalogController < ApplicationController
  def view
    @products = Product.all.order('store_owner asc')
    @cover_products = Product.limit(6)
    @catalog_products = Product.page(params[:page]).per(6).order('store_owner asc')
  end
end
