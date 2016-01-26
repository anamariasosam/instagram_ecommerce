class CatalogController < ApplicationController
  def flipbook
    @products = Product.all
    @cover_products = Product.limit(6)
  end

  def view
    @catalog_products = Product.page(params[:page]).per(6)
  end
end
