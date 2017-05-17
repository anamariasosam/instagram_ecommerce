class ProductsController < ApplicationController
  def index
    @categories = Category.all.order('name ASC')

    @products = Product
                          .page(params[:page])
                          .per(24)
                          .order('created_at DESC')
                          .includes(:store)
  end

  def show
    @product = Product.find(params[:id])
  end

end
