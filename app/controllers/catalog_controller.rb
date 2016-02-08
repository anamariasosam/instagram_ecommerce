class CatalogController < ApplicationController
  def view
    @products = Product.all
    @cover_products = Product.limit(6)
    @catalog_products = Product.page(params[:page]).per(6)
  end
end
